defmodule Rentals.Transactions.Rental do
  use Ecto.Schema
  import Ecto.Changeset

  schema "rentals" do
    belongs_to :user, Rentals.Accounts.User

    field :external_id, :string
    field :image, :string
    field :name, :string
    field :site_detail_url, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(rental, user, attrs) do
    rental
    |> cast(attrs, [:external_id, :image, :site_detail_url, :name])
    |> put_assoc(:user, user)
    |> validate_required([:external_id, :image, :site_detail_url, :name, :user])
    |> foreign_key_constraint(:user_id)
  end
end
