defmodule ApiBanking.Router do
  use Plug.Router

  plug(:match)
  plug(:dispatch)

  forward "/auth/token", to: ApiBanking.Router.Authentication
  forward "/api", to: ApiBanking.Router.Authorization 
  
  match(_, do: send_resp(conn, 404, ""))

end
