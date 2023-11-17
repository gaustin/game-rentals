# Rentals

Prereqs:

* Postgres
* Elixir ~> 1.15
* Erlang ~> 24

To start Rentals in development:

* Run `mix setup` to install and setup dependencies
* Start the application with `SEARCH_API_KEY=$YOUR_KEY_HERE SEARCH_API_URL="https://www.giantbomb.com/api/games/" mix phx.server` or inside IEx with `iex -S mix phx.server` (be sure to include the required env vars)

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

To run tests:

* `SEARCH_API_KEY=$YOUR_KEY_HERE SEARCH_API_URL="https://www.giantbomb.com/api/games/" mix test`

Expected user flow:

1. User registers
2. User confirms by visiting `http://localhost:4000/dev/mailbox`
3. User logs in
4. User searches for a game
5. User selects a title to rent
6. User can view titles they've rented

Note: This won't make calls to Giant Bomb unless you remove the cassettes backing the requests.
