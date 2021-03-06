defmodule ApiBanking.Router.Account do
    @moduledoc """
        Provides resources about account create and balance
    """ 

  use Plug.Router

  plug(:match)
  plug(Plug.Parsers, parsers: [:json], pass: ["application/json"], json_decoder: Jason)
  plug(:dispatch)

  get "/:account/balance" do
    
    response = ApiBanking.Controller.Account.checkBalance(account)

    conn
    |> put_resp_content_type(response.contentType)
    |> send_resp(response.httpStatusCode, Jason.encode!(response.body))
    
  end

  post "/" do
    
    response = ApiBanking.Controller.Account.create(conn.body_params)

    conn
    |> put_resp_content_type(response.contentType)
    |> send_resp(response.httpStatusCode, Jason.encode!(response.body))

  end

  match(_, do: send_resp(conn, 404, ""))

end
