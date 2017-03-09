defmodule SpeedfriendingSms.FriendTest do
  use SpeedfriendingSms.ModelCase

  alias SpeedfriendingSms.Friend

  @valid_attrs %{name: "some content", phone: "some content", verified: true}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Friend.changeset(%Friend{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Friend.changeset(%Friend{}, @invalid_attrs)
    refute changeset.valid?
  end
end
