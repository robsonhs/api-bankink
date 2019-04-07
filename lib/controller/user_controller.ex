defmodule ApiBanking.Controller.User do
  alias ApiBanking.Auth.Guardian

  def sing_in(conn) do
    case authenticate(conn.body_params) do
      {:ok, credentials} -> 
        IO.inspect(credentials)
        new_conn = Guardian.Plug.sign_in(conn, credentials, %{default: [:read, :write]})
        jwt = Guardian.Plug.current_token(new_conn)
        # %{:acess_token => jwt}
        IO.inspect(jwt)
        %{:msg => "authorized"}
      _ ->  %{:msg => "unauthorized"}
      # Isso pq no autenticate ele retorno :error ... como não coloquei por isso do erro
      # :error ->
    end
  end

  defp authenticate(%{"client_id" => username, "client_secret" => password}) do
    ApiBanking.Auth.Security.autenticate(username, password)
  end

  defp authenticate(_), do: :error

end

# conn = Guardian.Plug.api_sign_in(conn, account)
# jwt = Guardian.Plug.current_token(conn)
# {:ok, claims} = Guardian.Plug.claims(conn)
# exp = Map.get(claims, "exp") |> Integer.to_string
# {conn
#   |> Plug.Conn.put_resp_header("authorization", "Bearer #{jwt}")
#   |> Plug.Conn.put_resp_header("x-expires", exp),
# jwt}