defmodule CsvUploads.LocationsTest do
  use CsvUploads.DataCase

  alias CsvUploads.Locations

  describe "addresses" do
    alias CsvUploads.Locations.Address

    import CsvUploads.LocationsFixtures

    @invalid_attrs %{cep: nil, number: nil, street: nil}

    test "list_addresses/0 returns all addresses" do
      address = address_fixture()
      assert Locations.list_addresses() == [address]
    end

    test "get_address!/1 returns the address with given id" do
      address = address_fixture()
      assert Locations.get_address!(address.id) == address
    end

    test "create_address/1 with valid data creates a address" do
      valid_attrs = %{cep: "some cep", number: "some number", street: "some street"}

      assert {:ok, %Address{} = address} = Locations.create_address(valid_attrs)
      assert address.cep == "some cep"
      assert address.number == "some number"
      assert address.street == "some street"
    end

    test "create_address/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Locations.create_address(@invalid_attrs)
    end

    test "update_address/2 with valid data updates the address" do
      address = address_fixture()

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

    test "update_address/2 with invalid data returns error changeset" do
      address = address_fixture()
      assert {:error, %Ecto.Changeset{}} = Locations.update_address(address, @invalid_attrs)
      assert address == Locations.get_address!(address.id)
    end

    test "delete_address/1 deletes the address" do
      address = address_fixture()
      assert {:ok, %Address{}} = Locations.delete_address(address)
      assert_raise Ecto.NoResultsError, fn -> Locations.get_address!(address.id) end
    end

    test "change_address/1 returns a address changeset" do
      address = address_fixture()
      assert %Ecto.Changeset{} = Locations.change_address(address)
    end
  end
end
