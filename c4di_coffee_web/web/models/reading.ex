defmodule C4diCoffeeWeb.Reading do
  use C4diCoffeeWeb.Web, :model

  schema "readings" do
    field :reading_kg, :float
    field :time, Ecto.DateTime
    field :avg_since, Ecto.DateTime
    field :pot_name, :string

    timestamps
  end

  @required_fields ~w(reading_kg time avg_since pot_name)
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
