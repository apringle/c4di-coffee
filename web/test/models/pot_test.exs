defmodule C4diCoffeeWeb.PotTest do
  use C4diCoffeeWeb.ModelCase

  alias C4diCoffeeWeb.Pot

  @valid_attrs %{avg_cup: "120.5", empty: "120.5", full: "120.5", pot_name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Pot.changeset(%Pot{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Pot.changeset(%Pot{}, @invalid_attrs)
    refute changeset.valid?
  end
end
