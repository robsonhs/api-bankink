defmodule ApiBanking.Controller.Report do
    @moduledoc """
        Provides functions search/1 for annual, monthly or daily report extraction
    """

    @doc """
        Responsible for processing report requests, assembling the sqls according to the report 
        type and delegating to private functions to compose the sqls according to the filter
    """
    @spec search(%{}) :: ApiBanking.Util.Response.t()
    def search(request) do
 
        case request["type"] do
            "analytical" -> buildSQL(request, 
                                     "select   
                                        (case
                                            when t.operation_type = 'C' then 'Crédito'
                                            when t.operation_type = 'D' then 'Débito'
                                            when t.operation_type = 'TD' then 'Transferência'
                                            when t.operation_type = 'TT' then 'Ted'
                                        end) as operation,
                                        count(t.id) as quantity,
                                        sum(t.amount) as amount
                                     FROM tb_movements t 
                                     where t.operation_type in ('C','D','TD','TT')",
                                     "group by operation order by quantity"
                                    )
            "synthetic" -> buildSQL(request, 
                                     "select   
                                        count(t.id) as quantity,
                                        sum(t.amount) as amount
                                     FROM tb_movements t 
                                     where t.operation_type in ('C','D','TD','TT')",
                                     "order by quantity"
                                    )
            _ -> ApiBanking.Util.Response.build(400,%{:message => "type is analytical or synthetic"})
        end

    end

    defp buildSQL(request, preCondition, posCondition) do
    
        case request["filter"] do
            "year" ->  buildSQLYear(request, preCondition, posCondition)
            "month" ->  buildSQLMonth(request, preCondition, posCondition)
            "day" -> buildSQLDay(request, preCondition, posCondition)
            _ -> ApiBanking.Util.Response.build(400,%{:message => "filter is year, month or day"})  
        end

    end

    defp buildSQLYear(request, preCondition, posCondition) do
        
        try do

            condition = " and cast(date_part('year', t.date) as integer) = cast($1 as integer) "
            sql = preCondition <> condition <> posCondition
            ApiBanking.Repo.Report.search(sql, [String.to_integer(request["value"])])

        rescue
            
            e in _ ->  ApiBanking.Util.Response.build(400,%{:message => e.message})

        end


    end

    defp buildSQLMonth(request, preCondition, posCondition) do
        
        try do 

            condition = " and cast(date_part('year', t.date) as integer) = cast($1 as integer) 
                        and cast(date_part('month', t.date) as integer) = cast($2 as integer) "
            yearMonth = String.split(request["value"], "-")
            sql = preCondition <> condition <> posCondition
            ApiBanking.Repo.Report.search(sql, [String.to_integer(hd(yearMonth)),String.to_integer(hd(tl(yearMonth)))])

        rescue

            e in _ ->  ApiBanking.Util.Response.build(400,%{:message => e.message})
        
        end

    end

    defp buildSQLDay(request, preCondition, posCondition) do
        
        try do

            condition = " and date(t.date) = $1 "
            sql = preCondition <> condition <> posCondition
            ApiBanking.Repo.Report.search(sql, [Date.from_iso8601!(request["value"])])

        rescue

            e in _ ->  ApiBanking.Util.Response.build(400,%{:message => e.message})

        end

    end

end