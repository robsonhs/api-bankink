defmodule ApiBanking.Controller.DebitCredit do

    def perform(request) do

        if request["amount"] > 0 do
            
            case String.upcase(request["operation_type"]) do
                "D" -> debit(request)
                "C" -> credit(request)
                _ -> ApiBanking.Util.Response.build(400, %{:message => "operation type should be D to debit and C to credit"})
            end

        else

            ApiBanking.Util.Response.build(400, %{:message => "amount should be greater than zero"})

        end
        
    end

    defp credit(request) do
      
        ApiBanking.Repo.DebitCredit.performCredit(String.to_integer(request["account_number"]),request["amount"],request["operation_type"])

    end

    defp debit(request) do
        
        ApiBanking.Repo.DebitCredit.performDebit(String.to_integer(request["account_number"]),request["amount"],request["operation_type"])

    end

end
