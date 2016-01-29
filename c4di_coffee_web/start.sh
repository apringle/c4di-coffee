mix deps.get
elixir --erl "-smp disable" /elixir/bin/mix compile
npm install
mix ecto.create
mix ecto.migrate
mix phoenix.server