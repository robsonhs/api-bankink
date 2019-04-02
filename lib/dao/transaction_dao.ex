defmodule ApiBanking.TransactionDAO do

    def performCredit(request) do
       
        response = 
            Ecto.Adapters.SQL.query!(
                ApiBanking.Repo, 
                "select perform_credit::bigint from perform_credit($1, $2, $3)",
                [String.to_integer(request["number_account"]),request["amount"],request["operation_type"]])
                                         
        hd(hd(response.rows))

    end

    def performDebit(request) do
       
        response = 
            Ecto.Adapters.SQL.query!(
                ApiBanking.Repo, 
                "select perform_debit::bigint from perform_debit($1, $2, $3)",
                [String.to_integer(request["number_account"]),request["amount"],request["operation_type"]])
                                         
        hd(hd(response.rows))

    end

end 