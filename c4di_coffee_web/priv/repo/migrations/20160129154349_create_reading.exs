defmodule C4diCoffeeWeb.Repo.Migrations.CreateReading do
  use Ecto.Migration

  def change do
    create table(:readings) do
      add :reading_kg, :float
      add :time, :datetime
      add :avg_since, :datetime
      add :pot_name, :string

      timestamps
    end

  end
end
