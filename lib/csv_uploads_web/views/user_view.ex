defmodule CsvUploadsWeb.UserView do
  use CsvUploadsWeb, :view
  alias CsvUploadsWeb.{AddressView, UserView}

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user_with_addresses.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user_with_addresses.json")}
  end

  def render("user_with_addresses.json", %{user: user}) do
    %{
      id: user.id,
      name: user.name,
      email: user.email,
      password: user.password,
      addresses: render_many(user.addresses, AddressView, "address.json")
    }
  end
end
