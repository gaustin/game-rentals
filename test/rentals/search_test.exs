defmodule Rentals.SearchTest do
  use Rentals.DataCase
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  setup do
    ExVCR.Config.cassette_library_dir("fixture/vcr_cassettes")
    # Since we pass the API key in a query param we don't want to record it to the cassette
    ExVCR.Config.filter_url_params(true)
    :ok
  end

  test "successful search" do
    use_cassette "successful_search" do
      {:ok, results} =
        Rentals.Search.search(
          Application.get_env(:rentals, :search_api_url),
          Application.get_env(:rentals, :search_api_key),
          "Star"
        )

      assert results |> Enum.count() == 100
    end
  end

  test "timed-out search" do
    use_cassette "timeout_search" do
      {:error, reason} =
        Rentals.Search.search(
          Application.get_env(:rentals, :search_api_url),
          Application.get_env(:rentals, :search_api_key),
          "Star"
        )

      assert reason == "timeout"
    end
  end
end
