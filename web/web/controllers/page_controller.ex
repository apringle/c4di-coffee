defmodule C4diCoffeeWeb.PageController do
  use C4diCoffeeWeb.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
