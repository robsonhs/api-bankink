defmodule ApiBanking.Router.Register do
  use Plug.Router
  
  plug(:match)
  plug(Plug.Parsers, parsers: [:json], pass: ["application/json"], json_decoder: Jason)
  plug(:dispatch)

  get "/:account/balance" do
    
    response = ApiBanking.AccountController.findById(account)

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(response.httpCode, Jason.encode!(response.balance))
    
  end

  post "/accounts" do
    
    response = ApiBanking.AccountController.create(conn.body_params)

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(response.httpCode, Jason.encode!(response.msg))

  end

  match _ do
    send_resp(conn, 404, "bateu aki")
  end
end
