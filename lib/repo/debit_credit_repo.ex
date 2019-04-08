defmodule ApiBanking.DebitCreditRepo do
    
    def performCredit(number_account, amount, operation_type) do
       
        perform("select perform_credit::bigint from perform_credit($1, $2, $3)", number_account, amount, operation_type)

    end

    def performDebit(number_account, amount, operation_type) do
       
        perform("select perform_debit::bigint from perform_debit($1, $2, $3)", number_account, amount, operation_type)

    end

    defp perform(sql, number_account, amount, operation_type) do
        
        try do

            response = Ecto.Adapters.SQL.query!(ApiBanking.Repo, sql, [number_account, amount, operation_type])                     
            ApiBanking.Util.Response.build(%{:transaction_code => hd(hd(response.rows))})

        rescue
            
            e in _ ->   case e.postgres.message do
                            "account not found" -> ApiBanking.Util.Response.build(409,%{:message => e.postgres.message})
                            "insufficient balance" -> ApiBanking.Util.Response.build(412,%{:message => e.postgres.message})
                            _ -> ApiBanking.Util.Response.build(500,%{:message => e.postgres.message})
                        end
                        
        end

    end

end

#valor maior do quero