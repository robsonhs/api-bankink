defmodule ApiBanking.Router.Transaction do
    @moduledoc """
        Provides resources transactions debit, credit and transfer
    """ 

  use Plug.Router

  plug(Plug.Logger)
  plug(:match)
  plug(Plug.Parsers, parsers: [:json], pass: ["application/json"], json_decoder: Jason)
  plug(:dispatch)

  post "/" do
    
    response = ApiBanking.Controller.DebitCredit.perform(conn.body_params)

    conn
    |> put_resp_content_type(response.contentType)
    |> send_resp(response.httpStatusCode, Jason.encode!(response.body))

  end

  post "/transfer" do
    
    response = ApiBanking.Controller.Transfer.perform(conn.body_params)

    conn
    |> put_resp_content_type(response.contentType)
    |> send_resp(response.httpStatusCode, Jason.encode!(response.body))
    
  end

  match(_, do: send_resp(conn, 404, ""))
  
end
