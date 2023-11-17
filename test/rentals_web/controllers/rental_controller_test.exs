defmodule RentalsWeb.RentalControllerTest do
  use RentalsWeb.ConnCase

  setup :register_and_log_in_user

  import Rentals.TransactionsFixtures

  @create_attrs %{
    external_id: "some external_id",
    image: "some image",
    name: "some name",
    site_detail_url: "some site_detail_url"
  }
  @invalid_attrs %{external_id: nil, image: nil, name: nil, site_detail_url: nil}

  describe "index" do
    test "lists all rentals", %{conn: conn} do
      conn = get(conn, ~p"/rentals")
      assert html_response(conn, 200) =~ "Listing Rentals"
    end
  end

  describe "create rental" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/rentals", @create_attrs)

      assert redirected_to(conn) == ~p"/rentals"
      assert Phoenix.Flash.get(conn.assigns.flash, :info) =~ "Rental created successfully."
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/rentals", @invalid_attrs)
      assert redirected_to(conn) == ~p"/rentals"
      assert Phoenix.Flash.get(conn.assigns.flash, :error) =~ "Unable to rent title."
    end
  end

  describe "delete rental" do
    setup [:create_rental]

    test "deletes chosen rental", %{conn: conn, rental: rental} do
      conn = delete(conn, ~p"/rentals/#{rental}")
      assert redirected_to(conn) == ~p"/rentals"
    end
  end

  defp create_rental(context) do
    rental = rental_fixture(user: Map.get(context, :user))
    %{rental: rental}
  end
end
