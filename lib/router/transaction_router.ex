defmodule ApiBanking.Router.Transaction do
  use Plug.Router

  plug(Plug.Logger)
  plug(:match)
  plug(Plug.Parsers, parsers: [:json], pass: ["application/json"], json_decoder: Jason)
  plug(:dispatch)

  post "/transactions" do
    
    response = ApiBanking.DebitController.perform(conn.body_params)

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Jason.encode!(response))

  end

  post "/transaction/transfers" do
    
    response = ApiBanking.TransferController.perform(conn.body_params)

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Jason.encode!(response))
    
  end

  match _ do
    send_resp(conn, 404, "")
  end
end
