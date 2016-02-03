defmodule C4diCoffeeWeb.Pot do
  use C4diCoffeeWeb.Web, :model

  @primary_key {:pot_name, :string, []}
  @derive {Phoenix.Param, key: :pot_name}
  schema "pots" do
    field :empty, :float #Empty weight KG
    field :full, :float #Full weight KG
    field :avg_cup, :float #avg_cup weight KG

    timestamps
  end

  @required_fields ~w(pot_name empty full avg_cup)
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
