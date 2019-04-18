defmodule ApiBanking.Application do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec

    children = [
      supervisor(ApiBanking.Repo, []),
      {Plug.Cowboy, scheme: :http, plug: ApiBanking.Router, options: [port: 8080]},
    ]

    opts = [strategy: :one_for_one, name: ApiBanking.Supervisor]
    Supervisor.start_link(children, opts)

  end
  
end
