defmodule ApiWeb.TokenController do
  use ApiWeb, :controller

  action_fallback ApiWeb.FallbackController

  alias Data.User

  def auth(conn, %{"login" => login, "password" => password}) do
    # Find the user in the database based on the credentials sent with the request
    with user <- User.find(login) do
      IO.inspect user
      # Attempt to authenticate the user
      with {:ok, token, _claims} <- Api.Guardian.authenticate(%{user: user, password: password}) do
        # Render the token
        render conn, "token.json", token: token, username: login, roles: %{"space" => "admin"}
      end
    end
  end

end
