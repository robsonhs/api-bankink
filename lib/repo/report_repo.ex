defmodule ApiBanking.Repo.Report do
    
    def search(sql,params \\ []) do
        
        try do

            sql = "SELECT json_agg(transactions)::text FROM (" <> sql <> ") as transactions"
            {:ok, result} = Ecto.Adapters.SQL.query(ApiBanking.Repo, sql, params)  
            result = hd(hd (result.rows))

            case result do
                nil -> ApiBanking.Util.Response.build("[]")
                _   -> ApiBanking.Util.Response.build(result)
            end
         
        rescue
            
            e in _ ->   case e.postgres.message do
                            "account not found" -> ApiBanking.Util.Response.build(409,%{:message => e.postgres.message})
                            "insufficient balance" -> ApiBanking.Util.Response.build(412,%{:message => e.postgres.message})
                            _ -> ApiBanking.Util.Response.build(500,%{:message => "Error"})
                        end
                        
        end

    end

end