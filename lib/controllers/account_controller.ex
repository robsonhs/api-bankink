defmodule ApiBanking.AccountController do
    alias ApiBanking.Repo
    import Ecto.Query, only: [from: 2]

    def create(request) do
        
        try do

            request = Map.put(request,"balance","1000.0")
            changeset = ApiBanking.Account.changeset(%ApiBanking.Account{},request)
            Repo.insert(changeset)

            if changeset.valid? do
                
                %{:msg => "Account created sucessfully",:httpCode => 201}

            else
                
                %{:msg => "Fields required: number_account", :httpCode => 422}

            end
      
          rescue
           
            e in Ecto.ConstraintError -> %{:msg => "Account already register", :httpCode => 409}
            e in Postgrex.Error -> %{:msg => "Error while registering: " <> e.postgres.message, :httpCode => 422}
            _ -> %{:msg => "Error", :httpCode => 500}

        end 
      
    end

    def findById(number_account) do

        try do

            query = from u in "tb_account",
                    where: u.number_account == ^String.to_integer(number_account),
                    select: u.balance

            resultSet = Repo.all(query)

            firstItem = List.first(resultSet)

            if firstItem != nil do
                
                %{:balance => Decimal.to_string(hd resultSet),:httpCode => 200}

            else
                
                %{:msg => "Account not found",:httpCode => 200}

            end

        rescue

            _ -> %{:msg => "Error", :httpCode => 500}

        end 

    end

end