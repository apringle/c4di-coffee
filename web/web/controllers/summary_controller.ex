defmodule C4diCoffeeWeb.SummaryController do
  use C4diCoffeeWeb.Web, :controller

  alias C4diCoffeeWeb.Summary
  alias C4diCoffeeWeb.Pot
  alias C4diCoffeeWeb.Reading
  alias Timex.Date
  alias Timex.DateFormat  
  import Ecto.Query

  #Returns summaires for each pot in the system.
  def index(conn, _params) do
    #Get all the pots in the system
    pots = Repo.all(Pot)
    #Get the summaires for each pot
    summaries = Enum.map(pots, fn p -> 
        #Parse readings into a summary
        parsereading(getreadings(p), p)
       end) 

    #%Summary{pot_name: p.pot_name, avg_cup_size: 2, fill_level: 2, time: time } end) 
    render(conn, "index.json", summaries: summaries)
  end

  #returns summary for one pot in the system.
  def show(conn, %{"pot_name" => pot_name}) do
    pot = Repo.get!(Pot, pot_name) 
    summary = parsereading(getreadings(pot), pot)
    render(conn, "show.json", summary: summary)
  end

  def getreadings(pot) do
    #Grab all the readings for the given pot TODO Make this time dependant. get last 10 readings?
    query = from(r in Reading) |> where([r], r.pot_name == ^pot.pot_name)
    Repo.all(query)
  end

  #Parses a set of readings into a summary
  def parsereading(readings, pot_detail) do
    #Extract all the readings from the collection of readings
    reading_kgs = Enum.map(readings, fn r -> r.reading_kg end )
    
    #Calcualte the average from the readings
    fill_level_average = Enum.sum(reading_kgs) / Enum.count(reading_kgs)
    
    #Work out the percentage fullness
    pot_fill_level = fill_level_average / pot_detail.full * 100
    
    #output for debugging
    IO.puts "fill_level_average = #{fill_level_average}"
    IO.puts "pot_detial.full = #{pot_detail.full}"
    
    #Get the time the reading was calcualted? TODO Make this the last reading time.
    #time = Date.local |> DateFormat.format("{ISO}") |> elem(1)
    time = Enum.map(readings, fn r -> r.time end)|> Enum.max

    #Work out what % is the average cup
    avg_cup_percentage = pot_detail.avg_cup /(pot_detail.full - pot_detail.empty) * 100  

    #Return a new summary object
    %Summary{pot_name: pot_detail.pot_name, avg_cup_size: avg_cup_percentage, fill_level: pot_fill_level, time: time}
  end

end
