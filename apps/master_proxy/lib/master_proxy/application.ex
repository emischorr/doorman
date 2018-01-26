defmodule MasterProxy.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    port = (System.get_env("PORT") || "4004") |> String.to_integer
    cowboy = Plug.Adapters.Cowboy.child_spec(scheme: :http, plug: MasterProxy.Plug, options: [port: port])

    children = [
      cowboy
    ]

    opts = [strategy: :one_for_one, name: MasterProxy.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
