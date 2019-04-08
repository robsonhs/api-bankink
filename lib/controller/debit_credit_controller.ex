defmodule ApiBanking.DebitController do

    def perform(request) do
       
        operation_type = request["operation_type"]
        case String.upcase(operation_type) do
            "D" -> debit(request)
            "C" -> credit(request)
            _ -> ApiBanking.Util.Response.buildBadReques()
        end
        
    end

    defp credit(request) do
      
        ApiBanking.DebitCreditRepo.performCredit(String.to_integer(request["number_account"]),request["amount"],request["operation_type"])

    end

    defp debit(request) do
        
        ApiBanking.DebitCreditRepo.performDebit(String.to_integer(request["number_account"]),request["amount"],request["operation_type"])

    end

end
