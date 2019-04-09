defmodule ApiBanking.Controller.Transfer do

  def perform(request) do

    favored_bank_code = request["favored_bank_code"]
    case favored_bank_code do
        "732" -> transfer(request)
        _ -> ted(request)
    end
    
  end

  defp transfer(request) do
    
    ApiBanking.Repo.Transfer.performTransfer(request)

  end

  defp ted(request) do
    
    ApiBanking.Repo.Transfer.performTed(request)

  end

end
