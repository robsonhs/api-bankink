defmodule ApiBanking.Controller.Transfer do
  @moduledoc """
      Provides functions perform/1 to perform transfer and ted
  """

  @doc """
    Responsible for validating the request, identifying whether it is a transfer 
    or a ted and delegating to its private function.
  """
  @spec perform(%{}) :: ApiBanking.Util.Response.t()
  def perform(request) do

    if validateRequest(request) do
      
      case request["favored_bank_code"] do
        "875" -> transfer(request)
        _ -> ted(request)
      end

    else

      ApiBanking.Util.Response.build(400,%{:message => "Fields required: debit_account, debit_amount, favored_account, favored_agency, favored_bank_code, favored_document, favored_name"})

    end

    
  end

  defp transfer(request) do
    
    ApiBanking.Repo.Transfer.performTransfer(request)

  end

  defp ted(request) do
    
    ApiBanking.Repo.Transfer.performTed(request)

  end

  defp validateRequest(request) do
    
    with true <- !Blankable.blank?(request["debit_account"]), 
         true <- !Blankable.blank?(request["debit_amount"]),
         true <- !Blankable.blank?(request["favored_account"]),
         true <- !Blankable.blank?(request["favored_agency"]),
         true <- !Blankable.blank?(request["favored_bank_code"]),
         true <- !Blankable.blank?(request["favored_document"]),
         true <- !Blankable.blank?(request["favored_name"]) do
       
        true

    else
    
      false -> false

    end

  end

end
