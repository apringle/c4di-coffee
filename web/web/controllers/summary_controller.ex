defmodule C4diCoffeeWeb.SummaryController do
  use C4diCoffeeWeb.Web, :controller

  alias C4diCoffeeWeb.Summary
  alias C4diCoffeeWeb.Pot
  alias C4diCoffeeWeb.Reading
  alias Timex.Date
  alias Timex.DateFormat  

  def index(conn, _params) do
    pots = Repo.all(Pot)
    summaries =   
    Enum.map(pots, fn p -> parsereading(Repo.all(from r in Reading, where: r.pot_name == p.pot_name),p) end) 
    #%Summary{pot_name: p.pot_name, avg_cup_size: 2, fill_level: 2, time: time } end) 
    render(conn, "index.json", summaries: summaries)
  end

  def show(conn, %{"pot_name" => pot_name}) do
    summary = Repo.get!(Summary, pot_name)
    render(conn, "show.json", summary: summary)
  end

 def parsereading(readings, pot_detail) do
   reading_kgs = Enum.map(readings, fn r -> r.reading_kg end )
   fill_level_average = Enum.sum(reading_kgs) / Enum.max(reading_kgs)
   pot_fill_level = fill_level_average / pot_detail.full
   time = Date.local |> DateFormat.format("{ISO}") |> elem(1)
   newSummary = %Summary{pot_name: pot_detail.pot_name, avg_cup_size: pot_detail.avg_cup, fill_level: pot_fill_level, time: :calendar.local_time()}
    
  end

end
