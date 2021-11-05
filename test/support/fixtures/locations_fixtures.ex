defmodule CsvUploads.LocationsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `CsvUploads.Locations` context.
  """

  @doc """
  Generate a address.
  """
  def address_fixture(user, attrs \\ %{}) do
    {:ok, address} =
      attrs
      |> Enum.into(%{
        cep: "some cep",
        number: "some number",
        street: "some street"
      })
      |> then(& CsvUploads.Locations.create_address(user, &1))

    address
  end
end
