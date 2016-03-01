defmodule C4diCoffeeWeb.SummaryController do
  use C4diCoffeeWeb.Web, :controller
  use Timex
  alias C4diCoffeeWeb.Summary
  alias C4diCoffeeWeb.Pot
  alias C4diCoffeeWeb.Reading
  alias Ecto.DateTime
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
    query = from(r in Reading) 
    |> where([r], r.pot_name == ^pot.pot_name)
    |> order_by([r], desc: r.time)
    |> limit(5) #TODO Choose a good limit? depends on reading rate
    Repo.all(query)
  end

  #Parses a set of readings into a summary
  #TODO Assumes readings and pot_detail have things in them
  def parsereading(readings, pot_detail) do

    #Debug print readings
    Enum.map(readings, fn r -> IO.puts "Date: #{r.time}" end)

    #Extract all the readings from the collection of readings
    reading_kgs = Enum.map(readings, fn r -> r.reading_kg end )
    
    #Calcualte the average from the readings
    fill_level_average = Enum.sum(reading_kgs) / Enum.count(reading_kgs)
    
    #Work out the percentage fullness
    pot_fill_level = (fill_level_average - pot_detail.empty) / (pot_detail.full - pot_detail_empty) * 100
    
    #output for debugging
    IO.puts "fill_level_average = #{fill_level_average}"
    IO.puts "pot_detail.full = #{pot_detail.full}"
    
    #get the last reading time TODO relies on readings being ordeed by time..
    time = List.first(Enum.to_list(readings)).time

    #Work out what % is the average cup
    avg_cup_percentage = pot_detail.avg_cup /(pot_detail.full - pot_detail.empty) * 100  

    #Return a new summary object
    %Summary{pot_name: pot_detail.pot_name, avg_cup_size: avg_cup_percentage, fill_level: pot_fill_level, time: time}
  end

end
