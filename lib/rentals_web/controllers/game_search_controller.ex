defmodule RentalsWeb.GameSearchController do
  use RentalsWeb, :controller

  def search(conn, params) do
    search_params = Map.get(params, "search")

    if is_nil(search_params) do
      render(conn, "search.html", games: [])
    else
      with {:ok, games} <-
             search_mod(conn).search(
               Application.get_env(:rentals, :search_api_url),
               Application.get_env(:rentals, :search_api_key),
               search_params
             ) do
        render(conn, "search.html", games: games)
      else
        {:error, :timeout} ->
          conn
          |> put_flash(:error, "Search timed out.")
          |> redirect(to: ~p"/games/search")

        {:error, _reason} ->
          conn
          |> put_flash(:error, "Search failed to complete.")
          |> redirect(to: ~p"/games/search")
      end
    end
  end

  defp search_mod(conn) do
    conn.assigns[:search_mod] || Rentals.Search
  end
end
