defmodule ApiWeb.AccountView do
  use ApiWeb, :view

  def render("account_created.json", %{user: user}) do
    IO.inspect user
    # TODO: get expires_in from config
    %{user: %{
        login: user.login,
        name: user.name,
        lastname: user.lastname,
        email: user.email,
        attributes: user.attributes
      }
    }
  end

  def render("subscription_failed.json", %{changeset: %Ecto.Changeset{errors: changeset_errors}}) do
    errors = Enum.map(changeset_errors, fn {field, detail} ->
      %{
        source: %{ field: "#{field}" },
        title: "Invalid Attribute",
        detail: render_detail(detail)
      }
    end)
    %{errors: errors}
  end


  defp render_detail({message, values}) do
    Enum.reduce values, message, fn {k, v}, acc ->
      String.replace(acc, "%{#{k}}", to_string(v))
    end
  end

  defp render_detail(message) do
    message
  end
end
