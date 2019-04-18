defmodule ApiBanking.Repo.Transfer do
    @moduledoc """
        Provides functions performTransfer/1 and performTed/1 to carry out transfer and Ted
    """

    @doc """
        Responsible for the transfer, runs the debit in one account and the credit in another
    """
    @spec performTransfer(%{}) :: ApiBanking.Util.Response.t()
    def performTransfer(request) do
       
        try do

            response = 
                Ecto.Adapters.SQL.query!(
                    ApiBanking.Repo, 
                    "select perform_transfer::bigint from perform_transfer($1, $2, $3)",
                    [String.to_integer(request["debit_account"]),String.to_integer(request["favored_account"]),request["debit_amount"]])
            
            ApiBanking.Util.Response.build(%{:transaction_code => hd(hd(response.rows))})

            rescue
            
                e in _ ->   case e.postgres.message do
                                "account not found" -> ApiBanking.Util.Response.build(404,%{:message => e.postgres.message})
                                "insufficient balance" -> ApiBanking.Util.Response.build(412,%{:message => e.postgres.message})
                                _ -> ApiBanking.Util.Response.build(500,%{:message => e.postgres.message})
                            end
                    

        end

    end

    @doc """
        Responsible for performing ted, execute the debit in an account and register ted
    """
    @spec performTed(%{}) :: ApiBanking.Util.Response.t()
    def performTed(request) do
       
        try do

            response = 
                Ecto.Adapters.SQL.query!(
                    ApiBanking.Repo, 
                    "select perform_ted::bigint from perform_ted($1, $2, $3, $4, $5, $6, $7)",
                    [String.to_integer(request["debit_account"]),
                    request["debit_amount"],
                    request["favored_bank_code"],
                    request["favored_account"],
                    request["favored_agency"],
                    request["favored_name"],
                    request["favored_document"],
                    ])
                    
            ApiBanking.Util.Response.build(%{:transaction_code => hd(hd(response.rows))})

        rescue
            
            e in _ ->   case e.postgres.message do
                            "account not found" -> ApiBanking.Util.Response.build(404,%{:message => e.postgres.message})
                            "insufficient balance" -> ApiBanking.Util.Response.build(412,%{:message => e.postgres.message})
                            _ -> ApiBanking.Util.Response.build(500,%{:message => e.postgres.message})
                        end
                    
        end
        
    end

end