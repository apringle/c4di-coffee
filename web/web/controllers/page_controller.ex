defmodule C4diCoffeeWeb.PageController do
  use C4diCoffeeWeb.Web, :controller
  alias Phoenix.Controller.Flash
  alias C4diCoffeeWeb.Reading

  def index(conn, _params) do
    render conn, "index.html"
  end

  def data(conn, _params) do
  	readings = Reading
  	|> Repo.all
  	conn
  	|> put_flash(:info, readings |> Enum.count)
  	|> render("data.html", readings: readings)
  end
end
