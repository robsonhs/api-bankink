defmodule ApiBanking.Router do
  use Plug.Router

  plug(:match)
  plug(:dispatch)

  forward "/auth/token", to: ApiBanking.Router.AuthToken
  forward "/accounts", to: ApiBanking.Router.Register 
  forward "/register", to: ApiBanking.Router.Register 
  forward "/transactions", to: ApiBanking.Router.Transaction
  
  match(_, do: send_resp(conn, 404, ""))

end
