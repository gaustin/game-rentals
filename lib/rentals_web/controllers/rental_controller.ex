defmodule RentalsWeb.RentalController do
  use RentalsWeb, :controller

  alias Rentals.Transactions

  def index(conn, _params) do
    user = conn.assigns.current_user
    rentals = Transactions.list_rentals(user)
    render(conn, :index, rentals: rentals)
  end

  def create(conn, params) do
    user = conn.assigns.current_user
    rental_params = Map.take(params, ["external_id", "image", "name", "site_detail_url"])

    case Transactions.create_rental(user, rental_params) do
      {:ok, _rental} ->
        conn
        |> put_flash(:info, "Rental created successfully.")
        |> redirect(to: ~p"/rentals")

      {:error, %Ecto.Changeset{} = _changeset} ->
        conn
        |> put_flash(:error, "Unable to rent title.")
        |> redirect(to: ~p"/rentals")
    end
  end

  def delete(conn, %{"id" => id}) do
    user = conn.assigns.current_user
    rental = Transactions.get_rental!(id, user)

    if rental do
      {:ok, _rental} = Transactions.delete_rental(rental)

      conn
      |> put_flash(:info, "Rental deleted successfully.")
      |> redirect(to: ~p"/rentals")
    else
      conn
      |> put_flash(:info, "Rental not found.")
      |> redirect(to: ~p"/rentals")
    end
  end
end
