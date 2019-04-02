defmodule ApiBanking.DebitCreditRepo do
    
    def performCredit(number_account, amount, operation_type) do
       
        perform("select perform_credit::bigint from perform_credit($1, $2, $3)", number_account, amount, operation_type)

    end

    def performDebit(number_account, amount, operation_type) do
       
        perform("select perform_debit::bigint from perform_debit($1, $2, $3)", number_account, amount, operation_type)

    end

    defp perform(sql, number_account, amount, operation_type) do
        
        response = Ecto.Adapters.SQL.query!(ApiBanking.Repo, sql, [number_account, amount, operation_type])                     
        hd(hd(response.rows))

    end

end