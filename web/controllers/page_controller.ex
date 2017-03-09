defmodule SfSms.PageController do
  use SfSms.Web, :controller
  alias SfSms.Repo
  alias SfSms.Friend
  import Ecto.Query, only: [ from: 2 ]

  def index(conn, _params) do
    render conn, "index.html"
  end

  def list(conn, _params, notes) do
    verified = Repo.all from f in Friend,
        where: (f.verified == true),
        order_by: [ desc: f.inserted_at ]
    nonverified = Repo.all from f in Friend,
        where: (f.verified == false),
        order_by: [ desc: f.inserted_at ]
    render conn, "list.html", ver: verified, nonver: nonverified, notes: notes
  end

  def list(conn, params = %{ "revoke" => id }) do
    friend = Repo.get!(Friend, id)

    if friend.verified do
      acct_update = Ecto.Changeset.change friend, %{ verified: false }
      acct = Repo.update!(acct_update, [])

      SfSms.Texter.send_text_message(friend.phone, "You've been checked out of Speed Friending. You will not be included in matching.️")
    end

    list(conn, params, "Revoked " <> id)
  end

  def list(conn, params = %{ "delete" => id }) do
    case Repo.get(Friend, id) do
      friend ->
        IO.inspect friend
        Repo.delete!(friend, [])
        list(conn, params, "Deleted '" <> friend.name <> "' (" <> id <> ")")
      _ ->
        list(conn, params, "No Id: " <> id)
    end
  end

  def list(conn, params = %{ "verify" => id }) do
    friend = Repo.get!(Friend, id)

    if friend.verified == false do
      acct_update = Ecto.Changeset.change friend, %{ verified: true }
      acct = Repo.update!(acct_update, [])

      SfSms.Texter.send_text_message(friend.phone, "You're checked in ✌️")
    end

    list(conn, params, "Verified '" <> friend.name <> "' (" <> id <> ")")
  end

  def list(conn, params) do
    list(conn, params, "")
  end

  def print(conn, params) do
    verified = Repo.all from f in Friend,
        where: (f.verified == true),
        order_by: [ desc: f.inserted_at ]
    render conn, "print.html", ver: verified
  end
end
