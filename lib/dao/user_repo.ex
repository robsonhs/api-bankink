defmodule ApiBanking.Repo.User do
    alias ApiBanking.Repo

    def findById(username), do: Repo.get(ApiBanking.User, username) 

    def findByIdCredentials(username) do
        
        user = Repo.get(ApiBanking.User, username);
        ApiBanking.Auth.Credentials.build(user)

    end

end