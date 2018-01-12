defmodule ApiWeb.TokenView do
  use ApiWeb, :view

  def render("token.json", %{token: token, username: username, roles: roles}) do
    render("token.json", %{token: token})
    |> Map.merge(%{username: username})
    |> Map.merge(%{roles: roles})
  end
  def render("token.json", %{token: token}) do
    # TODO: get expires_in from config
    %{
      access_token: token,
      token_type: "Bearer",
      expires_in: 86400
    }
  end
end
