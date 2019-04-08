defmodule ApiBanking.TransferController do

  def perform(request) do

    favored_bank_code = request["favored_bank_code"]
    case favored_bank_code do
        "732" -> transfer(request)
        _ -> ted(request)
    end
    
  end

  defp transfer(request) do
    
    ApiBanking.TransferRepo.performTransfer(request)

  end

  defp ted(request) do
    
    ApiBanking.TransferRepo.performTed(request)

  end

end
