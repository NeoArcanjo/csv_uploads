defmodule CsvUploads.LocationsTest do
  use CsvUploads.DataCase

  alias CsvUploads.Locations
  alias CsvUploads.Accounts

  @create_user %{
    email: "some email",
    name: "some name",
    password: "some password"
  }

  setup do
    {:ok, user} = Accounts.create_user(@create_user)
    {:ok, user: user}
  end

  describe "addresses" do
    alias CsvUploads.Locations.Address

    import CsvUploads.LocationsFixtures

    @invalid_attrs %{cep: nil, number: nil, street: nil}

    test "list_addresses/0 returns all addresses", %{user: user} do
      address = address_fixture(user)
      assert Locations.list_addresses() == [address]
    end

    test "get_address!/1 returns the address with given id", %{user: user} do
      address = address_fixture(user)
      assert Locations.get_address!(address.id) == address
    end

    test "create_address/1 with valid data creates a address", %{user: user} do
      valid_attrs = %{cep: "some cep", number: "some number", street: "some street"}

      assert {:ok, %Address{} = address} = Locations.create_address(user, valid_attrs)
      assert address.cep == "some cep"
      assert address.number == "some number"
      assert address.street == "some street"
    end

    test "create_address/1 with invalid data returns error changeset", %{user: user} do
      assert {:error, %Ecto.Changeset{}} = Locations.create_address(user, @invalid_attrs)
    end

    test "update_address/2 with valid data updates the address", %{user: user} do
      address = address_fixture(user)

      update_attrs = %{
        cep: "some updated cep",
        number: "some updated number",
        street: "some updated street"
      }

      assert {:ok, %Address{} = address} = Locations.update_address(address, update_attrs)
      assert address.cep == "some updated cep"
      assert address.number == "some updated number"
      assert address.street == "some updated street"
    end

    test "update_address/2 with invalid data returns error changeset", %{user: user} do
      address = address_fixture(user)
      assert {:error, %Ecto.Changeset{}} = Locations.update_address(address, @invalid_attrs)
      assert address == Locations.get_address!(address.id)
    end

    test "delete_address/1 deletes the address", %{user: user} do
      address = address_fixture(user)
      assert {:ok, %Address{}} = Locations.delete_address(address)
      assert_raise Ecto.NoResultsError, fn -> Locations.get_address!(address.id) end
    end

    test "change_address/1 returns a address changeset", %{user: user} do
      address = address_fixture(user)
      assert %Ecto.Changeset{} = Locations.change_address(address)
    end
  end
end
