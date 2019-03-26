defmodule ApiBankingTest do
  use ExUnit.Case
  doctest ApiBanking

  test "greets the world" do
    retorno = ApiBanking.TransferController.transfer(nil)
    retorno
  end
end
