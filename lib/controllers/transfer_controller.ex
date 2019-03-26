defmodule ApiBanking.TransferController do
  alias ApiBanking.Repo
  def transfer(request) do
    IO.inspect(request)
    IO.puts(request["debit_account"])
    IO.puts("ApiBanking.TransferController.transfer")

    changeset = %ApiBanking.Account{number_account: 6564860322, name_holder: "ROBSON HENRIQUE DA SILVA", document_holder: "07531035677", balance: 1000.0 }

 #   case Repo.insert(changeset) do
 #     {:ok, _account} -> IO.puts("SUCESS")
 #     {:error, _changeset} -> IO.puts("ERROR") 
 #   end 

   try do

      Repo.insert(changeset)
      %{:msg => "Account created sucessfully"}

    rescue
      e in Ecto.InvalidURLError -> %{:msg => "erro de url"}
      e in Ecto.ConstraintError -> %{:msg => "Conta já cadastrada"}
      e in RuntimeError -> %{:msg => "Erro desconhecido"}
      _ -> %{:msg => "Error created sucessfully"}
    end 

  end
end
