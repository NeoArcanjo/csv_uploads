defmodule CsvUploads.Locations.Address do
  use Ecto.Schema
  import Ecto.Changeset

  schema "addresses" do
    field :cep, :string
    field :number, :string
    field :street, :string
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(address, attrs) do
    address
    |> cast(attrs, [:cep, :street, :number])
    |> validate_required([:cep, :street, :number])
  end
end
