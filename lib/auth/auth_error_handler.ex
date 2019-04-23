defmodule ApiBanking.Auth.Guardian.AuthErrorHandler do
  @moduledoc """
    Provides function auth_error/3 to handle authentication and authorization errors
  """
  import Plug.Conn

  @spec auth_error(Plug.Conn.t(), {any(), any()}, any()) :: Plug.Conn.t()
  def auth_error(conn, {type, _reason}, _opts) do

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(401, Jason.encode!(%{message: to_string(type)}))
    
  end

end