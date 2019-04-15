defmodule ApiBanking.Repo.DebitCredit do
    @moduledoc """
        Provides functions performCredit/3 and performDebit/3 to make debits and credits
    """
    
    @doc """
        Responsible for executing debit and generating facts in the movement table
    """
    @spec performCredit(Integer.t(), Float.t(), String.t()) :: ApiBanking.Util.Response.t()
    def performCredit(account_number, amount, operation_type) do
       
        perform("select perform_credit::bigint from perform_credit($1, $2, $3)", account_number, amount, operation_type)

    end
    
    @doc """
        Responsible for executing credit and generating facts in the movement table
    """
    @spec performDebit(Integer.t(), Float.t(), String.t()) :: ApiBanking.Util.Response.t()
    def performDebit(account_number, amount, operation_type) do
       
        perform("select perform_debit::bigint from perform_debit($1, $2, $3)", account_number, amount, operation_type)

    end

    defp perform(sql, account_number, amount, operation_type) do
        
        try do

            response = Ecto.Adapters.SQL.query!(ApiBanking.Repo, sql, [account_number, amount, operation_type])                     
            ApiBanking.Util.Response.build(%{:transaction_code => hd(hd(response.rows))})

        rescue
            
            e in _ ->   case e.postgres.message do
                            "account not found" -> ApiBanking.Util.Response.build(404,%{:message => e.postgres.message})
                            "insufficient balance" -> ApiBanking.Util.Response.build(409,%{:message => e.postgres.message})
                            _ -> ApiBanking.Util.Response.build(500,%{:message => e.postgres.message})
                        end
                        
        end

    end

end