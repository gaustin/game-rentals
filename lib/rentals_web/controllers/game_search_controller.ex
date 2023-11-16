defmodule RentalsWeb.GameSearchController do
  use RentalsWeb, :controller

  def search(conn, params) do
    search_params = Map.get(params, "search")

    {:ok, games} =
      if is_nil(search_params) do
        {:ok, []}
      else
        search_mod(conn).search(
          Application.get_env(:rentals, :search_api_url),
          Application.get_env(:rentals, :search_api_key),
          search_params
        )
      end

    render(conn, "search.html", games: games)
  end

  defp search_mod(conn) do
    conn.assigns[:search_mod] || Rentals.Search
  end
end
