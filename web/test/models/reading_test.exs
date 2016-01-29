defmodule C4diCoffeeWeb.ReadingTest do
  use C4diCoffeeWeb.ModelCase

  alias C4diCoffeeWeb.Reading

  @valid_attrs %{avg_since: "2010-04-17 14:00:00", pot_name: "some content", reading_kg: "120.5", time: "2010-04-17 14:00:00"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Reading.changeset(%Reading{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Reading.changeset(%Reading{}, @invalid_attrs)
    refute changeset.valid?
  end
end
