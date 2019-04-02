defmodule ApiBanking.TransferRepo do
    
    def perform(request) do
       
        response = 
            Ecto.Adapters.SQL.query!(
                ApiBanking.Repo, 
                "select perform_transfer::bigint from perform_transfer($1, $2, $3)",
                [String.to_integer(request["debit_account"]),String.to_integer(request["favored_account"]),request["debit_amount"]])
                
        hd(hd(response.rows))

    end

end