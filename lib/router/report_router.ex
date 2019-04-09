defmodule ApiBanking.Router.Report do
    use Plug.Router

    plug(:match)
    plug(Plug.Parsers, parsers: [:json], pass: ["application/json"], json_decoder: Jason)
    plug(:dispatch)

    match(_, do: send_resp(conn, 404, ""))

end