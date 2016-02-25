defmodule C4diCoffeeWeb.SummaryView do
  use C4diCoffeeWeb.Web, :view

  def render("index.json", %{summaries: summaries}) do
    %{data: render_many(summaries, C4diCoffeeWeb.SummaryView, "summary.json")}
  end

  def render("show.json", %{summary: summary}) do
    %{data: render_one(summary, C4diCoffeeWeb.SummaryView, "summary.json")}
  end

  def render("summary.json", %{summary: summary}) do
    %{pot_name: summary.pot_name,
      time: summary.time,
      fill_level: summary.fill_level,
      avg_cup_size: summary.avg_cup_size}
  end
end
