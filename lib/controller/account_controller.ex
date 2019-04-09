defmodule ApiBanking.Controller.Account do
    alias ApiBanking.Repo
    import Ecto.Query, only: [from: 2]

    def create(request) do
        
        try do

            request = Map.put(request,"balance","1000.0")
            changeset = ApiBanking.Account.changeset(%ApiBanking.Account{},request)
            Repo.insert(changeset)

            if changeset.valid? do
                
                ApiBanking.Util.Response.build(201,%{:message => "Account created sucessfully"})

            else
                
                ApiBanking.Util.Response.build(422,%{:message => "Fields required: number_account"})

            end
      
          rescue
            
            e in Ecto.ConstraintError -> ApiBanking.Util.Response.build(409,%{:message => "Account already register"})
            e in Postgrex.Error -> ApiBanking.Util.Response.build(422,%{:message => "Error while registering: " <> e.postgres.message})
            _ -> ApiBanking.Util.Response.buildError(%{:message => "Balance inquiry service unavailable!"})

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
                
                ApiBanking.Util.Response.build(%{:balance => Decimal.to_string(hd resultSet)})

            else
                
                ApiBanking.Util.Response.build(404,%{:message => "Account not found"})

            end

        rescue
            
            _ -> ApiBanking.Util.Response.buildError(%{:message => "Balance inquiry service unavailable!"})

        end 

    end

end