defmodule C4diCoffeeWeb.Repo.Migrations.CreateSummary do
  use Ecto.Migration

  def change do
    create table(:summaries) do
      add :pot_name, :string
      add :time, :datetime
      add :fill_level, :integer
      add :avg_cup_size, :integer

      timestamps
    end

  end
end
