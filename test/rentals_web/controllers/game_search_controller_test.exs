defmodule RentalsWeb.GameSearchControllerTest do
  use RentalsWeb.ConnCase

  import Mox
  setup :verify_on_exit!

  setup :register_and_log_in_user

  describe "search" do
    setup do
      SearchMock
      |> stub(:search, fn
        _, _, "Example" ->
          {:ok,
           [
             %Rentals.Search.Result{
               name: "Example Game",
               site_detail_url: "http://example.com",
               image: "http://example.com/image"
             }
           ]}

        _, _, _ ->
          {:ok, []}
      end)

      :ok
    end

    test "lists all games", %{conn: conn} do
      conn = conn |> assign_mocks() |> get(~p"/games/search", search: "Example")
      assert html_response(conn, 200) =~ "Example Game"
    end

    test "lists no games when no search term is provided", %{conn: conn} do
      conn = conn |> assign_mocks() |> get(~p"/games/search")
      assert html_response(conn, 200) =~ "No games found"
    end
  end

  defp assign_mocks(conn) do
    conn
    |> Plug.Conn.assign(:search_mod, SearchMock)
  end
end
