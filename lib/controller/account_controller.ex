defmodule ApiBanking.Controller.Account do
    alias ApiBanking.Repo
    import Ecto.Query, only: [from: 2]

    def create(request) do
        
        try do
            
            account_number = Misc.Random.number(8)
            request = Map.put(request,"account_number", account_number)
            request = Map.put(request,"balance","1000.0")
            IO.inspect(request)
            changeset = ApiBanking.Account.changeset(%ApiBanking.Account{},request)
            Repo.insert(changeset)

            if changeset.valid? do
                
                ApiBanking.Util.Response.build(201,%{:account_number => account_number})

            else
                
                ApiBanking.Util.Response.build(400,%{:message => "Fields required: number_account"})

            end
      
          rescue
            
            e in Ecto.ConstraintError -> ApiBanking.Util.Response.build(409,%{:message => "Account already register"})
            e in Postgrex.Error -> ApiBanking.Util.Response.build(422,%{:message => "Error while registering: " <> e.postgres.message})
            _ -> ApiBanking.Util.Response.buildError(%{:message => "Balance inquiry service unavailable!"})

        end 
      
    end

    def checkBalance(account_number) do

        try do

            query = from u in "tb_account",
                    where: u.account_number == ^String.to_integer(account_number),
                    select: u.balance

            resultSet = Repo.all(query)

            firstItem = List.first(resultSet)

            if firstItem != nil do
                
                ApiBanking.Util.Response.build(%{:balance => Decimal.to_string(hd resultSet)})

            else
                
                ApiBanking.Util.Response.build(404,%{:message => "Account not found"})

            end

        rescue
            
            e in _ -> ApiBanking.Util.Response.buildError(%{:message => "Balance inquiry service unavailable!" <> e.postgres.message})

        end 

    end

end