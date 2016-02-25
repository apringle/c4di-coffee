defmodule C4diCoffeeWeb.Repo.Migrations.CreatePot do
  use Ecto.Migration

  def change do
    create table(:pots, primary_key: false) do
      add :pot_name, :string, primary_key: true
      add :empty, :float
      add :full, :float
      add :avg_cup, :float

      timestamps
    end

  end
end
