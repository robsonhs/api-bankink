defmodule ApiBanking.Router.AuthToken do
    use Plug.Router

    plug(:match)
    plug(Plug.Parsers, parsers: [Plug.Parsers.URLENCODED, Plug.Parsers.MULTIPART])
    plug(:dispatch)

    post "/" do

        if conn.body_params["grant_type"] === "client_credentials" do
            
            result = ApiBanking.Controller.User.sing_in(conn)
            IO.inspect(result)

            conn
            |> put_resp_content_type("application/json")
            |> send_resp(200,"")

        else
           
            conn
            |> send_resp(400,"")

        end

    end

    match _ do
        
        send_resp(conn, 404, "bateu aki")

    end

end