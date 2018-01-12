defmodule AdminWeb.BackendController do
  use AdminWeb, :controller

  def dashboard(conn, _params) do
    render(conn, "dashboard.html")
  end
end
