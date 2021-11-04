defmodule CsvUploads.LocationsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `CsvUploads.Locations` context.
  """

  @doc """
  Generate a address.
  """
  def address_fixture(attrs \\ %{}) do
    {:ok, address} =
      attrs
      |> Enum.into(%{
        cep: "some cep",
        number: "some number",
        street: "some street"
      })
      |> CsvUploads.Locations.create_address()

    address
  end
end
