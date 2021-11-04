defmodule CsvUploadsWeb.AddressView do
  use CsvUploadsWeb, :view
  alias CsvUploadsWeb.AddressView

  def render("index.json", %{addresses: addresses}) do
    %{data: render_many(addresses, AddressView, "address.json")}
  end

  def render("show.json", %{address: address}) do
    %{data: render_one(address, AddressView, "address.json")}
  end

  def render("address.json", %{address: address}) do
    %{
      id: address.id,
      cep: address.cep,
      street: address.street,
      number: address.number
    }
  end
end
