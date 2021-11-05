# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     CsvUploads.Repo.insert!(%CsvUploads.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
{:ok, user} =
  CsvUploads.Accounts.create_user(%{name: "Teste", email: "test@test.com", password: "test"})

{:ok, address} =
  CsvUploads.Locations.create_address(user, %{
    street: "Rua Teste",
    number: "123",
    cep: "12345-678"
  })
