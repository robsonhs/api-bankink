defmodule ApiBanking.DebitController do

    def perform(request) do
       
        operation_type = request["operation_type"]
        case String.upcase(operation_type) do
            "D" -> debit(request)
            "C" -> credit(request)
            _ -> %{:msg => "Nem crédito nem débito"}
        end
        
    end

    defp credit(request) do
      
        # sql = "select * from credit("
        #       <> request["number_account"]
        #       <> ","
        #       <> request["amount"]
        #       <> ","
        #       <> "'"
        #       <> request["operation_type"]
        #       <> "'"    
        #       <> ")" 
        #Ecto.Adapters.SQL.stream(ApiBanking.Repo, "select * from perform_credit(6564860, 23000.44, 'c')")
        #|> Enum.to_list()
       # |> result_to_struct
        #%{:msg => resultSet}
        #Ecto.Adapters.SQL.query(ApiBanking.Repo, "select perform_credit::bigint from perform_credit(6564860, 23000.44, 'c')")
        ApiBanking.TransactionDAO.insertCredit(request)

    end

    # defp result_to_struct(res) do
    #     cols = Enum.map res.columns, &(String.to_atom(&1))     
    #     Enum.map res.rows, fn(row) -> struct(__MODULE__, Enum.zip(cols, row)) end
    # end

    defp debit(request) do
        
        %{:msg => "Débito"}

    end
#%{"amount" => 34.55, "number_account" => "6564860", "operation_type" => "C"}
end
