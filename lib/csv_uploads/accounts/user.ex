defmodule CsvUploads.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias CsvUploads.Locations.Address

  schema "users" do
    field :email, :string
    field :name, :string
    field :password, :string

    has_many :addresses, Address, on_replace: :delete
    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email, :password])
    |> validate_required([:name, :email, :password])
    |> cast_assoc(:addresses)
    |> unique_constraint(:email)
  end
end
