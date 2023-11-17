defmodule Rentals.Transactions do
  @moduledoc """
  The Transactions context.
  """

  import Ecto.Query, warn: false
  alias Rentals.Repo

  alias Rentals.Transactions.Rental

  @doc """
  Returns the list of rentals.

  ## Examples

      iex> list_rentals()
      [%Rental{}, ...]

  """
  def list_rentals(user) do
    query = from(r in Rental, where: r.user_id == ^user.id)
    Repo.all(query) |> Repo.preload(:user)
  end

  @doc """
  Gets a single rental.

  Raises `Ecto.NoResultsError` if the Rental does not exist.

  ## Examples

      iex> get_rental!(123)
      %Rental{}

      iex> get_rental!(456)
      ** (Ecto.NoResultsError)

  """
  def get_rental!(id, user) do
    query = from(r in Rental, where: r.id == ^id and r.user_id == ^user.id)
    Repo.one!(query) |> Repo.preload(:user)
  end

  @doc """
  Creates a rental.

  ## Examples

      iex> create_rental(%{field: value})
      {:ok, %Rental{}}

      iex> create_rental(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_rental(user, attrs) do
    %Rental{}
    |> Rental.changeset(user, attrs)
    |> Repo.insert()
  end

  def delete_rental(%Rental{} = rental) do
    Repo.delete(rental)
  end
end
