defmodule C4diCoffeeWeb.Summary do
  use C4diCoffeeWeb.Web, :model

  schema "summaries" do
    field :pot_name, :string
    field :time, Ecto.DateTime
    field :fill_level, :integer
    field :avg_cup_size, :integer

    timestamps
  end

  @required_fields ~w(pot_name time fill_level avg_cup_size)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
