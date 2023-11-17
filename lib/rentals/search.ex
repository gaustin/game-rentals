defmodule Rentals.Search do
  @callback search(String.t(), String.t(), String.t()) :: {:ok, map()} | {:error, term()}
  def search(api_url, api_key, query) do
    query_params = %{
      format: :json,
      filter: "name:#{query}",
      api_key: api_key,
      field_list: "name,guid,site_detail_url,image"
    }

    uri =
      api_url
      |> URI.parse()
      |> Map.put(:query, URI.encode_query(query_params))
      |> URI.to_string()

    case HTTPoison.get(uri) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, body |> JSON.decode!() |> Map.get("results") |> Enum.map(&build_struct/1)}

      {:ok, %HTTPoison.Response{status_code: 429}} ->
        {:error, "Rate limit exceeded"}

      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, reason}
    end
  end

  defp build_struct(raw_result) do
    %Rentals.Search.Result{
      name: raw_result["name"],
      site_detail_url: raw_result["site_detail_url"],
      image: raw_result["image"]["thumb_url"],
      external_id: raw_result["guid"]
    }
  end
end
