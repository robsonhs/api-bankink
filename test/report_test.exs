defmodule ApiBanking.Test.Report do
    use ExUnit.Case
    doctest ApiBanking

    test "Bad request filter" do
        
        request = %{"filter" => nil, "type" => "synthetic", "value" => "2019"}
        response = ApiBanking.Controller.Report.search(request)
        assert response.httpStatusCode == 400

    end

    test "Bad request type" do
        
        request = %{"filter" => "year", "type" => nil, "value" => "2019"}
        response = ApiBanking.Controller.Report.search(request)
        assert response.httpStatusCode == 400
        
    end

    test "Bad request value" do
        
        request = %{"filter" => "year", "type" => "synthetic", "value" => nil}
        response = ApiBanking.Controller.Report.search(request)
        assert response.httpStatusCode == 400

    end

    test "year synthetic "  do
        
        request = %{"filter" => "year", "type" => "synthetic", "value" => "2019"}
        response = ApiBanking.Controller.Report.search(request)
        assert response.httpStatusCode == 200

    end

    test "month synthetic " do
       
        request = %{"filter" => "month", "type" => "synthetic", "value" => "2019-04"}
        response = ApiBanking.Controller.Report.search(request)
        assert response.httpStatusCode == 200

    end

    test "day synthetic " do

        request = %{"filter" => "day", "type" => "synthetic", "value" => "2019-04-07"}
        response = ApiBanking.Controller.Report.search(request)
        assert response.httpStatusCode == 200

    end

    test "year analytical "  do
        
        request = %{"filter" => "year", "type" => "analytical", "value" => "2019"}
        response = ApiBanking.Controller.Report.search(request)
        assert response.httpStatusCode == 200

    end

    test "month analytical " do
       
        request = %{"filter" => "month", "type" => "analytical", "value" => "2019-04"}
        response = ApiBanking.Controller.Report.search(request)
        assert response.httpStatusCode == 200

    end

    test "day analytical " do

        request = %{"filter" => "day", "type" => "analytical", "value" => "2019-04-07"}
        response = ApiBanking.Controller.Report.search(request)
        assert response.httpStatusCode == 200

    end

end 