defmodule ApiBanking.Router.Authentication do
    use Plug.Router

    plug(:match)
    plug(Plug.Parsers, parsers: [Plug.Parsers.URLENCODED, Plug.Parsers.MULTIPART])
    plug(:dispatch)

    post "/" do

        if conn.body_params["grant_type"] === "client_credentials" do
            
            response = ApiBanking.Controller.User.sing_in(conn)
            conn
            |> put_resp_content_type(response.contentType)
            |> send_resp(response.httpStatusCode,Jason.encode!(response.body))

        else
           
            response = ApiBanking.Util.Response.buildBadReques()
            conn
            |> put_resp_content_type(response.contentType)
            |> send_resp(response.httpStatusCode,Jason.encode!(response.body))

        end

    end

    match(_, do: send_resp(conn, 404, ""))

end