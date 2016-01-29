ExUnit.start

Mix.Task.run "ecto.create", ~w(-r C4diCoffeeWeb.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r C4diCoffeeWeb.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(C4diCoffeeWeb.Repo)

