defmodule ApiBanking.Test.DebitCredit do
    use ExUnit.Case
    doctest ApiBanking

    test "Debit" do
        
        request =   %{
            "document_holder" => "1234",
            "name_holder" => "Test "
        }
        response = ApiBanking.Controller.Account.create(request)
        account = response.body[:account_number]
        account = Integer.to_string(account)
        request = %{"account_number" => account, "amount" => 220.15, "operation_type" => "D"}
        response = ApiBanking.Controller.DebitCredit.perform(request)
        assert response.httpStatusCode == 200 

    end

    test "Credit" do
        
        request =   %{
            "document_holder" => "1234",
            "name_holder" => "Test "
        }
        response = ApiBanking.Controller.Account.create(request)
        account = response.body[:account_number]
        account = Integer.to_string(account)
        request = %{"account_number" => account, "amount" => 220.15, "operation_type" => "C"}
        response = ApiBanking.Controller.DebitCredit.perform(request)
        assert response.httpStatusCode == 200 

    end

    test "Operation type not found" do
        
        request = %{"account_number" => 8, "amount" => 220.15, "operation_type" => "J"}
        response = ApiBanking.Controller.DebitCredit.perform(request)
        assert response.httpStatusCode == 400 

    end

    test "amount less than zero" do
        
        request = %{"account_number" => 8, "amount" => 220.15, "operation_type" => "J"}
        response = ApiBanking.Controller.DebitCredit.perform(request)
        assert response.httpStatusCode == 400 

    end

    test "insufficient balance" do
        
        request = %{"account_number" => "8", "amount" => 220.15, "operation_type" => "d"}
        response = ApiBanking.Controller.DebitCredit.perform(request)
        assert response.httpStatusCode == 409 

    end

end