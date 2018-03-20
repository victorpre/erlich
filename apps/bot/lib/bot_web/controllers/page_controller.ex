defmodule BotWeb.PageController do
  use BotWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
