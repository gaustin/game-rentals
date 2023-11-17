defmodule Rentals.TransactionsTest do
  use Rentals.DataCase

  alias Rentals.Transactions

  describe "rentals" do
    alias Rentals.Transactions.Rental

    import Rentals.TransactionsFixtures

    @invalid_attrs %{external_id: nil, image: nil, name: nil, site_detail_url: nil}

    test "list_rentals/0 returns all rentals" do
      rental = rental_fixture()
      assert Transactions.list_rentals(rental.user) == [rental]
    end

    test "get_rental!/1 returns the rental with given id" do
      rental = rental_fixture()
      assert Transactions.get_rental!(rental.id, rental.user) == rental
    end

    test "create_rental/1 with valid data creates a rental" do
      valid_attrs = %{
        external_id: "some external_id",
        image: "some image",
        name: "some name",
        site_detail_url: "some site_detail_url"
      }

      assert {:ok, %Rental{} = rental} =
               Transactions.create_rental(Rentals.AccountsFixtures.user_fixture(), valid_attrs)

      assert rental.external_id == "some external_id"
      assert rental.image == "some image"
      assert rental.name == "some name"
      assert rental.site_detail_url == "some site_detail_url"
    end

    test "create_rental/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} =
               Transactions.create_rental(Rentals.AccountsFixtures.user_fixture(), @invalid_attrs)
    end

    test "delete_rental/1 deletes the rental" do
      rental = rental_fixture()
      assert {:ok, %Rental{}} = Transactions.delete_rental(rental)
      assert_raise Ecto.NoResultsError, fn -> Transactions.get_rental!(rental.id, rental.user) end
    end
  end
end
