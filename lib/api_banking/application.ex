defmodule ApiBanking.Application do
  use Application

  def start(_type, _args) do
    children = [
      {Plug.Cowboy, scheme: :http, plug: ApiBanking.Router.Example, options: [port: 8080]},
      {Plug.Cowboy, scheme: :http, plug: ApiBanking.Router.Register, options: [port: 8081]},
      {Plug.Cowboy, scheme: :http, plug: ApiBanking.Router.Transaction, options: [port: 8082]}
    ]

    opts = [strategy: :one_for_one, name: ApiBanking.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
