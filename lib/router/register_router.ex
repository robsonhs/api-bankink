defmodule ApiBanking.Router.Register do
  use Plug.Router

  plug(:match)
  plug(Plug.Parsers, parsers: [:urlencoded, :multipart])
  plug(Plug.Parsers, parsers: [:json], pass: ["application/json"], json_decoder: Jason)
  plug(:dispatch)

  get "/register/users" do
    IO.inspect(conn.body_params)
    send_resp(conn, 200, "/register/users")
  end

  post "/register/users" do
    IO.inspect(conn.body_params)
    send_resp(conn, 200, "/register/users")
  end

  get "/register/accounts" do
    IO.inspect(conn.body_params)
    send_resp(conn, 200, "/register/accounts")
  end

  match _ do
    send_resp(conn, 404, "")
  end
end
