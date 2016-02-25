defmodule C4diCoffeeWeb.SummaryTest do
  use C4diCoffeeWeb.ModelCase

  alias C4diCoffeeWeb.Summary

  @valid_attrs %{avg_cup_size: 42, fill_level: 42, pot_name: "some content", time: "2010-04-17 14:00:00"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Summary.changeset(%Summary{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Summary.changeset(%Summary{}, @invalid_attrs)
    refute changeset.valid?
  end
end
