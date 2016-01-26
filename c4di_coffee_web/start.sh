mix deps.get
elixir --erl "-smp disable" /elixir/bin/mix compile
mix phoenix.server