defmodule CsvUploads.Locations.Address do
  use Ecto.Schema
  import Ecto.Changeset
  alias CsvUploads.Accounts.User

  schema "addresses" do
    field :cep, :string
    field :number, :string
    field :street, :string

    belongs_to :user, User, foreign_key: :user_id
    timestamps()
  end

  @doc false
  def changeset(address, attrs) do
    address
    |> cast(attrs, [:cep, :street, :number])
    |> validate_required([:cep, :street, :number])
    |> assoc_constraint(:user)
  end
end
