FROM apringle/docker-phoenix

RUN mix deps.get
RUN elixir --erl "-smp disable" /elixir/bin/mix compile
