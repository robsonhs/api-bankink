defmodule ApiBanking.Router.Transaction do
  use Plug.Router

  plug(Plug.Logger)
  plug(:match)
  plug(Plug.Parsers, parsers: [:json], pass: ["application/json"], json_decoder: Jason)
  plug(:dispatch)

  post "/transaction/debits" do
    IO.inspect(conn.body_params)

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Jason.encode!(%{path: "/transaction/debits"}))
  end

  post "/transaction/transfers" do
    response = ApiBanking.TransferController.transfer(conn.body_params)

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Jason.encode!(response))
  end

  get "/transaction/balances/:account" do
    IO.inspect(account)

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Jason.encode!(%{path: "/transaction/balances/{account}"}))
  end

  match _ do
    send_resp(conn, 404, "")
  end
end
