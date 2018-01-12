defmodule ApiWeb.FallbackController do
  use ApiWeb, :controller

  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> render(ApiWeb.ErrorView, "404.json")
  end

  def call(conn, {:error, :unauthorized}) do
    conn
    |> put_status(:unauthorized)
    |> render(ApiWeb.ErrorView, "401.json")
  end

  def call(conn, _assigns) do
    conn
    |> put_status(500)
    |> render(ApiWeb.ErrorView, "500.json")
  end

  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> render(ApiWeb.ErrorView, :errors, data: changeset)
  end

end
