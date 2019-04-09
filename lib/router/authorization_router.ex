defmodule ApiBanking.Router.Authorization do
    use Plug.Router
 
    @claims %{typ: "access"}
    plug Guardian.Plug.Pipeline, otp_app: :api_banking,
                                  module: ApiBanking.Auth.Guardian,
                                  error_handler: ApiBanking.Auth.Guardian.AuthErrorHandler
    plug Guardian.Plug.VerifySession, claims: @claims
    plug Guardian.Plug.VerifyHeader, claims: @claims, realm: "Bearer"
    plug Guardian.Plug.EnsureAuthenticated
    plug Guardian.Plug.LoadResource, ensure: true
    plug(:match)
    plug(Plug.Parsers, parsers: [:json], pass: ["application/json"], json_decoder: Jason)
    plug(:dispatch)

    forward "/accounts", to: ApiBanking.Router.Account
    forward "/transactions", to: ApiBanking.Router.Transaction
    forward "/report", to: ApiBanking.Router.Report

    match(_, do: send_resp(conn, 404, ""))

end