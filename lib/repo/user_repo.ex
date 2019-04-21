defmodule ApiBanking.Repo.User do
    @moduledoc """
        Provides functions findById/1 and findByIdCredentials/1 to get users
    """
    alias ApiBanking.Repo

    @doc """
        Responsible for getting the user from the login
    """
    @spec findById(String.t()) :: any()
    def findById(username), do: Repo.get(ApiBanking.User, username) 

    @doc """
        Responsible for getting the user from login and transforming into credential
    """
    def findByIdCredentials(username) do
       
        try do
            
            user = Repo.get(ApiBanking.User, username);
            {:ok, ApiBanking.Credentials.build(user)}
        
        rescue

            e in _ ->   {:error, e.postgres.message}

        end

    end

end