defmodule ApiBanking.AccountRepo do
    alias ApiBanking.Repo

    def create(request) do
        
        changeset = %ApiBanking.Account{
                        number_account: request["number_account"], 
                        name_holder: request["name_holder"], 
                        document_holder: request["document_holder"], 
                        balance: 1000.0 
                    }

        try do

            Repo.insert(changeset)
            %{:msg => "Account created sucessfully"}
    
        rescue
            _e in Ecto.ConstraintError -> %{:msg => "Account already created"}
            _ -> %{:msg => "Error inserting account: "}

        end 

    end

end