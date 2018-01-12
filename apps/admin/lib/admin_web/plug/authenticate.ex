defmodule AdminWeb.Plug.Authenticate do
  require Logger
  import Plug.Conn
  import Phoenix.Controller, only: [redirect: 2, put_flash: 3]

  def init(options) do
    options
  end

  def call(conn, _options) do
    if is_logged_in(get_session(conn, :current_user)) do
      # Logger.debug "User is logged in"
      conn |> assign(:current_user, get_session(conn, :current_user))
    else
      # Logger.debug "User not logged in!"
      #TODO: add current url as a param to login view -> redirect after login
      conn |> put_flash(:info, "You need to login in!") |> redirect(to: "/login") |> halt
    end
  end

  defp is_logged_in(user_session) do
    case user_session do
      nil -> false
      _   -> true
    end
  end

end
