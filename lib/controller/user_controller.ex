defmodule ApiBanking.Controller.User do
    @moduledoc """
        Provides functions sing_in/1 to perform the authentication of a user
    """

  @doc """
    Responsible for authenticating a user, obtains the user from the database, 
    validates the password and generates a token for access
  """
  @spec sing_in(atom() | %{body_params: any()}) :: ApiBanking.Util.Response.t()
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
    
    credentials = ApiBanking.Repo.User.findByIdCredentials(username)
        
    if password == credentials.password do
        
        credentials = %ApiBanking.Credentials{credentials | password: nil}
        {:ok, credentials}

    else
        
        {:error}    

    end
    
  end

  defp authenticate(_), do: :error

end