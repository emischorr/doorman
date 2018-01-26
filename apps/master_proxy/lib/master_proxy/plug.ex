defmodule MasterProxy.Plug do
  def init(options) do
    options
  end

  def call(conn, _opts) do
    cond do
      conn.request_path =~ ~r{/api} ->
        ApiWeb.Endpoint.call(conn, [])
      true ->
        AdminWeb.Endpoint.call(conn, [])
    end
  end
end
