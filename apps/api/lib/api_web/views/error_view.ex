defmodule ApiWeb.ErrorView do
  use ApiWeb, :view

  def render("404.json", %{message: message}) do
    %{errors: %{detail: message}}
  end

  def render("404.json", _assigns) do
    %{errors: %{detail: "Not found"}}
  end

  def render("401.json", _assigns) do
    %{errors: %{detail: "Not authorized!"}}
  end

  def render("422.json", %{errors: %Ecto.Changeset{errors: changeset_errors}}) do
    errors = Enum.map(changeset_errors, fn {field, detail} ->
      %{
        source: %{ field: "#{field}" },
        title: "Invalid Attribute",
        detail: render_detail(detail)
      }
    end)
    %{errors: errors}
  end

  def render("422.json", %{errors: errors}) when is_bitstring(errors) do
    %{errors: errors}
  end

  def render("422.json", _assigns) do
    %{errors: %{detail: "Bad request"}}
  end

  def render("500.json", _assigns) do
    %{errors: %{detail: "Internal server error"}}
  end

  # In case no render clause matches or no
  # template is found, let's render it as 500
  def template_not_found(_template, assigns) do
    render "500.json", assigns
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
