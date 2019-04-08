defmodule ApiBanking.Controller.User do

  def sing_in(conn) do
    case authenticate(conn.body_params) do
      
      {:ok, credentials} -> 
        conn = ApiBanking.Auth.Guardian.Plug.sign_in(conn, credentials, %{default: [:read, :write]})
        jwt = ApiBanking.Auth.Guardian.Plug.current_token(conn)
        ApiBanking.Util.Response.build(%{:acess_token => jwt})

      _ ->  ApiBanking.Util.Response.buildUnauthorized()

    end
  end

  defp authenticate(%{"client_id" => username, "client_secret" => password}) do
    ApiBanking.Auth.Security.autenticate(username, password)
  end

  defp authenticate(_), do: :error

end