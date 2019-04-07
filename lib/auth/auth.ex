defmodule ApiBanking.Auth.Security do

    def autenticate(username, password) do
        
        credentials = ApiBanking.Repo.User.findByIdCredentials(username)
        
        if password == credentials.password do
            
            credentials = %ApiBanking.Auth.Credentials{credentials | password: nil}
            {:ok, credentials}

        else
            
            {:error}    

        end

    end

end