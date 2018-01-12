defmodule AdminWeb.PageController do
  use AdminWeb, :controller

  plug :put_layout, "no_session.html"

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
