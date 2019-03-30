defmodule ApiBankingTest do
  use ExUnit.Case
  doctest ApiBanking
  
  test "greets the world" do
    # retorno = ApiBanking.AccountController.create(%{
    #   "document_holder" => "49994949",
    #   "name_holder" => "Robson Henrique da Silva",
    #   "number_account" => "9876552"
    # })
    # IO.inspect(retorno)
    account_number = 6564860000
    response = ApiBanking.AccountController.findById(account_number)
    IO.inspect(response)
    # [head | tail] = response
    # flo = Decimal.to_string(hd response)
    # IO.puts(flo)
  end
end
