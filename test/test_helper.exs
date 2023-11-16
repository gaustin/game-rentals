ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(Rentals.Repo, :manual)

Mox.defmock(SearchMock, for: Rentals.Search)
