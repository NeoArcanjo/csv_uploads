defmodule CsvUploadsWeb.AddressController do
  use CsvUploadsWeb, :controller

  alias CsvUploads.Locations
  alias CsvUploads.Locations.Address
  alias CsvUploads.Accounts
  action_fallback CsvUploadsWeb.FallbackController

  @spec index(Plug.Conn.t(), map) :: Plug.Conn.t()
  def index(conn, %{"user_id" => user_id}) do
    user = Accounts.get_user!(user_id)
    render(conn, "index.json", addresses: user.addresses)
  end

  @spec create(any, map) :: any
  def create(conn, %{"user_id" => user_id, "address" => address_params}) do
    user = Accounts.get_user!(user_id)
    with {:ok, %Address{} = address} <- Locations.create_address(user, address_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.user_address_path(conn, :show, user_id, address))
      |> render("show.json", address: address)
    end
  end

  @spec show(Plug.Conn.t(), map) :: Plug.Conn.t()
  def show(conn, %{"id" => id}) do
    address = Locations.get_address!(id)
    render(conn, "show.json", address: address)
  end

  @spec update(any, map) :: any
  def update(conn, %{"id" => id, "address" => address_params}) do
    address = Locations.get_address!(id)

    with {:ok, %Address{} = address} <- Locations.update_address(address, address_params) do
      render(conn, "show.json", address: address)
    end
  end

  @spec delete(any, map) :: any
  def delete(conn, %{"id" => id}) do
    address = Locations.get_address!(id)

    with {:ok, %Address{}} <- Locations.delete_address(address) do
      send_resp(conn, :no_content, "")
    end
  end
end
