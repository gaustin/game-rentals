defmodule Rentals.Repo.Migrations.CreateRentals do
  use Ecto.Migration

  def change do
    create table(:rentals) do
      add :external_id, :string, null: false
      add :image, :string
      add :site_detail_url, :string
      add :name, :string, null: false
      add :user_id, references(:users, on_delete: :delete_all), null: false

      timestamps(type: :utc_datetime)
    end

    create index(:rentals, [:user_id])
  end
end
