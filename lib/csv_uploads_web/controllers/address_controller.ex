defmodule CsvUploadsWeb.AddressController do
  use CsvUploadsWeb, :controller

  alias CsvUploads.Locations
  alias CsvUploads.Locations.Address

  action_fallback CsvUploadsWeb.FallbackController

  def index(conn, _params) do
    addresses = Locations.list_addresses()
    render(conn, "index.json", addresses: addresses)
  end

  def create(conn, %{"address" => address_params}) do
    with {:ok, %Address{} = address} <- Locations.create_address(address_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.address_path(conn, :show, address))
      |> render("show.json", address: address)
    end
  end

  def show(conn, %{"id" => id}) do
    address = Locations.get_address!(id)
    render(conn, "show.json", address: address)
  end

  def update(conn, %{"id" => id, "address" => address_params}) do
    address = Locations.get_address!(id)

    with {:ok, %Address{} = address} <- Locations.update_address(address, address_params) do
      render(conn, "show.json", address: address)
    end
  end

  def delete(conn, %{"id" => id}) do
    address = Locations.get_address!(id)

    with {:ok, %Address{}} <- Locations.delete_address(address) do
      send_resp(conn, :no_content, "")
    end
  end
end
