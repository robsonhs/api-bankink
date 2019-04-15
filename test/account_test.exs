defmodule ApiBanking.Test.Account do
    use ExUnit.Case
    doctest ApiBanking

    test "Create account" do
        
        request = %{
                        "document_holder" => "1234",
                        "name_holder" => "Test"
                    }
    
        response = ApiBanking.Controller.Account.create(request)
        assert response.httpStatusCode == 201    

    end

    test "Create account error name_holder not found" do
        
        request = %{
                        "document_holder" => "123",
                    }
   
        response = ApiBanking.Controller.Account.create(request)
        assert response.httpStatusCode == 422 

    end

    test "Create account error document_holder not found" do
        
        request =   %{
                        "name_holder" => "Test"
                    }
   
        response = ApiBanking.Controller.Account.create(request)
        assert response.httpStatusCode == 422 

    end

    test "Check balance" do
        
        request =   %{
                        "document_holder" => "1234",
                        "name_holder" => "Test "
                    }
    
        response = ApiBanking.Controller.Account.create(request)
        
        account = response.body[:account_number]
        account = Integer.to_string(account)
        response = ApiBanking.Controller.Account.checkBalance(account)

        assert response.httpStatusCode == 200 

     end

end