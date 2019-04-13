defmodule ApiBanking.Router.Report do
    use Plug.Router

    plug(:match)
    plug(Plug.Parsers, parsers: [:json], pass: ["application/json"], json_decoder: Jason)
    plug(:dispatch)

    get "/transaction" do
        
        response = ApiBanking.Controller.Report.search(conn.query_params)

        case response.httpStatusCode do
            200 ->  conn
                    |> put_resp_content_type(response.contentType)
                    |> send_resp(response.httpStatusCode, ["{\"data\":", response.body, "}"])
            _   ->  conn
                    |> put_resp_content_type(response.contentType)
                    |> send_resp(response.httpStatusCode, Jason.encode!(response.body))

        end
        

    end

    match(_, do: send_resp(conn, 404, ""))

end