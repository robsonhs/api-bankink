defmodule ApiBanking.TransferController do
  alias ApiBanking.Repo

  def perform(request) do

    operation_type = request["favored_bank_code"]
    case operation_type do
        "732" -> transfer(request)
        _ -> ted(request)
    end
    
  end

  # transferencia (interna) não precisamos guardar informações do favorecido pois o favorecido é um outro cliente do próprio banco
  # diferenciamos apenas o tipo de crédito e débito pois uma transferencia gerará um débito em uma conta e um crédito em outra
  defp transfer(request) do
    
    ApiBanking.TransferRepo.perform(request)

  end

  defp ted(request) do
    
    ApiBanking.DebitCreditRepo.performDebit(String.to_integer(request["debit_account"]),request["debit_amount"],"TED")
    #Necessário incluir na tabela de transferencia as transações

  end

end
