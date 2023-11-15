defmodule Rentals.Repo do
  use Ecto.Repo,
    otp_app: :rentals,
    adapter: Ecto.Adapters.Postgres
end
