defmodule ApiBanking.TransferController do
  def transfer(request) do
    IO.inspect(request)
    IO.puts(request["debit_account"])
    IO.puts("ApiBanking.TransferController.transfer")
    %{:transaction_codigo => 123, :transaction_description => "Succesful transaction"}
  end
end
