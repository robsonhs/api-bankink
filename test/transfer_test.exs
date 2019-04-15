defmodule ApiBanking.Test.Transfer do
    use ExUnit.Case
    doctest ApiBanking

    test "Transfer" do
        
        request =   %{
            "document_holder" => "1234",
            "name_holder" => "Test "
        }

        response = ApiBanking.Controller.Account.create(request)
        account = response.body[:account_number]
        debit_account = Integer.to_string(account)
        response = ApiBanking.Controller.Account.create(request)
        account = response.body[:account_number]
        debit_account = Integer.to_string(account)


        request =   %{
                        "debit_account" => debit_account,
                        "debit_amount" => 4.12,
                        "favored_account" => debit_account,
                        "favored_agency" => "0001",
                        "favored_bank_code" => "732",
                        "favored_document" => "07531035677",
                        "favored_name" => "Meu nome favorecido"
                    }

        response = ApiBanking.Controller.Transfer.perform(request)

        assert response.httpStatusCode == 200

    end

    test "Ted" do
        
        request =   %{
            "document_holder" => "1234",
            "name_holder" => "Test "
        }

        response = ApiBanking.Controller.Account.create(request)
        account = response.body[:account_number]
        debit_account = Integer.to_string(account)

        request =   %{
                        "debit_account" => debit_account,
                        "debit_amount" => 4.12,
                        "favored_account" => "6564860",
                        "favored_agency" => "0001",
                        "favored_bank_code" => "077",
                        "favored_document" => "07531035677",
                        "favored_name" => "Meu nome favorecido"
                    }

        response = ApiBanking.Controller.Transfer.perform(request)

        assert response.httpStatusCode == 200

    end

    test "Transfer/ted bad request nil" do
        
        request =   %{
            "document_holder" => "1234",
            "name_holder" => "Test "
        }

        response = ApiBanking.Controller.Account.create(request)
        account = response.body[:account_number]
        debit_account = Integer.to_string(account)
        response = ApiBanking.Controller.Account.create(request)
        account = response.body[:account_number]
        debit_account = Integer.to_string(account)


        request =   %{
                        "debit_account" => debit_account,
                        "debit_amount" => nil,
                        "favored_account" => debit_account,
                        "favored_agency" => "6754",
                        "favored_bank_code" => "732",
                        "favored_document" => "07531035677",
                        "favored_name" => "Meu nome favorecido"
                    }

        response = ApiBanking.Controller.Transfer.perform(request)

        assert response.httpStatusCode == 400

    end

    test "Transfer/ted bad request blank" do
        
        request =   %{
            "document_holder" => "1234",
            "name_holder" => "Test "
        }

        response = ApiBanking.Controller.Account.create(request)
        account = response.body[:account_number]
        debit_account = Integer.to_string(account)

        request =   %{
                        "debit_account" => debit_account,
                        "debit_amount" => 4.55,
                        "favored_account" => "",
                        "favored_agency" => "6754",
                        "favored_bank_code" => "732",
                        "favored_document" => "07531035677",
                        "favored_name" => "Meu nome favorecido"
                    }

        response = ApiBanking.Controller.Transfer.perform(request)

        assert response.httpStatusCode == 400

    end

    test "Ted insufficient balance" do
        
        request =   %{
            "document_holder" => "1234",
            "name_holder" => "Test "
        }

        response = ApiBanking.Controller.Account.create(request)
        account = response.body[:account_number]
        debit_account = Integer.to_string(account)

        request =   %{
                        "debit_account" => debit_account,
                        "debit_amount" => 4000000.55,
                        "favored_account" => "765432",
                        "favored_agency" => "6754",
                        "favored_bank_code" => "732",
                        "favored_document" => "07531035677",
                        "favored_name" => "Meu nome favorecido"
                    }

        response = ApiBanking.Controller.Transfer.perform(request)

        assert response.httpStatusCode == 412

    end

    test "Transfer insufficient balance" do
        
        request =   %{
            "document_holder" => "1234",
            "name_holder" => "Test "
        }

        response = ApiBanking.Controller.Account.create(request)
        account = response.body[:account_number]
        debit_account = Integer.to_string(account)
        response = ApiBanking.Controller.Account.create(request)
        account = response.body[:account_number]
        debit_account = Integer.to_string(account)


        request =   %{
                        "debit_account" => debit_account,
                        "debit_amount" => 40000000.90,
                        "favored_account" => debit_account,
                        "favored_agency" => "6754",
                        "favored_bank_code" => "732",
                        "favored_document" => "07531035677",
                        "favored_name" => "Meu nome favorecido"
                    }

        response = ApiBanking.Controller.Transfer.perform(request)

        assert response.httpStatusCode == 412

    end

    test "Transfer account debit not found" do
        
        request =   %{
            "document_holder" => "1234",
            "name_holder" => "Test "
        }

        response = ApiBanking.Controller.Account.create(request)
        account = response.body[:account_number]
        debit_account = Integer.to_string(account)


        request =   %{
                        "debit_account" => debit_account,
                        "debit_amount" => 40.90,
                        "favored_account" => "4",
                        "favored_agency" => "6754",
                        "favored_bank_code" => "732",
                        "favored_document" => "07531035677",
                        "favored_name" => "Meu nome favorecido"
                    }

        response = ApiBanking.Controller.Transfer.perform(request)

        assert response.httpStatusCode == 404

    end

end
