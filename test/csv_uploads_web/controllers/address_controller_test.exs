defmodule CsvUploadsWeb.AddressControllerTest do
  use CsvUploadsWeb.ConnCase

  import CsvUploads.LocationsFixtures

  alias CsvUploads.Locations.Address
  alias CsvUploads.Accounts

  @create_user %{
    email: "some email",
    name: "some name",
    password: "some password"
  }

  @create_attrs %{
    cep: "some cep",
    number: "some number",
    street: "some street"
  }
  @update_attrs %{
    cep: "some updated cep",
    number: "some updated number",
    street: "some updated street"
  }
  @invalid_attrs %{cep: nil, number: nil, street: nil}

  setup %{conn: conn} do
    {:ok, user} = Accounts.create_user(@create_user)
    {:ok, conn: put_req_header(conn, "accept", "application/json"), user: user}
  end

  describe "index" do
    test "lists all addresses", %{conn: conn, user: user} do
      conn = get(conn, Routes.user_address_path(conn, :index, user.id))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create address" do
    test "renders address when data is valid", %{conn: conn, user: user} do
      conn =
        post(conn, Routes.user_address_path(conn, :create, user.id),
          user_id: user.id,
          address: @create_attrs
        )

      assert %{"id" => id} = json_response(conn, 201)["data"]
      conn = get(conn, Routes.user_address_path(conn, :show, user.id, id))

      assert %{
               "id" => ^id,
               "cep" => "some cep",
               "number" => "some number",
               "street" => "some street"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, user: user} do
      conn =
        post(conn, Routes.user_address_path(conn, :create, user.id),
          user_id: user.id,
          address: @invalid_attrs
        )

      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update address" do
    setup [:create_address]

    test "renders address when data is valid", %{
      conn: conn,
      address: %Address{id: id} = address,
      user: user
    } do
      conn =
        put(conn, Routes.user_address_path(conn, :update, user.id, address),
          user_id: user.id,
          address: @update_attrs
        )

      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.user_address_path(conn, :show, user.id, id))

      assert %{
               "id" => ^id,
               "cep" => "some updated cep",
               "number" => "some updated number",
               "street" => "some updated street"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, user: user, address: address} do
      conn =
        put(conn, Routes.user_address_path(conn, :update, user.id, address),
          user_id: user.id,
          address: @invalid_attrs
        )

      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete address" do
    setup [:create_address]

    test "deletes chosen address", %{conn: conn, user: user, address: address} do
      conn = delete(conn, Routes.user_address_path(conn, :delete, user.id, address))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.user_address_path(conn, :show, user.id, address))
      end
    end
  end

  defp create_address(%{user: user}) do
    address = address_fixture(user)
    %{address: address}
  end
end
