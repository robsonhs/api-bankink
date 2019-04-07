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
    # account_number = 6564860000
    # response = ApiBanking.AccountController.findById(account_number)
    # IO.inspect(response)
    # [head | tail] = response
    # flo = Decimal.to_string(hd response)
    # IO.puts(flo)

    # response = Ecto.Adapters.SQL.query!(ApiBanking.Repo, "select perform_credit::bigint from perform_credit(6564860, 23000.44, 'c')")
    # #alorEnum = elem(response, 1)
    # coluna = response.rows
    # primeiro = hd coluna
    # IO.inspect(hd primeiro)
    # IO.inspect(hd(hd(response.rows)))
    # account_number = 6564860000
    
    # try do
      
    #   sql = "select perform_debit::bigint from perform_debit($1, $2, $3)"
    #   response = Ecto.Adapters.SQL.query!(ApiBanking.Repo, sql, [6564860, 43.66, "d"])  
    #   IO.inspect(hd(hd(response.rows)))

    # rescue
          
    #   e in Postgrex.Error -> %{:msg => "Error while registering: " <> e.postgres.message, :httpCode => 422}
    #   _ -> %{:msg => "Error", :httpCode => 500}

    # end

  end
end