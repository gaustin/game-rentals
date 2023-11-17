defmodule Rentals.TransactionsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Rentals.Transactions` context.
  """

  @doc """
  Generate a rental.
  """
  def rental_fixture(attrs \\ %{}) do
    user = attrs[:user] || Rentals.AccountsFixtures.user_fixture()

    {:ok, rental} =
      Rentals.Transactions.create_rental(
        user,
        attrs
        |> Enum.into(%{
          external_id: "some external_id",
          image: "some image",
          name: "some name",
          site_detail_url: "some site_detail_url"
        })
      )

    rental
  end
end
