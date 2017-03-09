# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     SfSms.Repo.insert!(%SfSms.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

NimbleCSV.define(SeedsParser, separator: ",", escape: "\"")

"priv/repo/friends_demo.csv"
|> File.stream!
|> SeedsParser.parse_stream
|> Stream.map(fn [name, phone, verif] ->
  %SfSms.Friend{name: name, phone: phone, verified: verif == "1"}
end)
# Filter out people with same phone number already in db
|> Stream.filter(fn %{ phone: phone } ->
  nil == SfSms.Repo.get_by(SfSms.Friend, phone: phone)
end)
# This portion of the Stream will always run before the previous
# since we are lazy streaming!
# This means that even if we have a duplicate phone number in our data,
# it will be filtered out, because the previous entries will be inserted
# before it is filtered out.
|> Stream.each(fn friend ->
  IO.inspect(friend)
  SfSms.Repo.insert!(friend)
end)
|> Stream.run()

