defmodule ApiBanking.Test.Authentication do
    use ExUnit.Case
    use Plug.Test
    doctest ApiBanking

    test "login authorized" do
        
        request =  conn(:post, "/auth/token", %{"client_id": "admin", "client_secret": "admin", "grant_type": "client_credentials"}) 
                |> put_req_header("content-type", "multipart/form-data")

        response = ApiBanking.Router.call(request,[])
        assert response.status == 200

    end

    test "login unauthorized" do
        
        request =  conn(:post, "/auth/token", %{"client_id": "admin", "client_secret": "error", "grant_type": "client_credentials"}) 
                |> put_req_header("content-type", "multipart/form-data")

        response = ApiBanking.Router.call(request,[])
        assert response.status == 401

    end

    test "Authorization" do
        
        request =  conn(:post, "/auth/token", %{"client_id": "admin", "client_secret": "admin", "grant_type": "client_credentials"}) 
                |> put_req_header("content-type", "multipart/form-data")

        response = ApiBanking.Router.call(request,[])
        {:ok, access_token} = Jason.decode(response.resp_body)
        access_token = access_token["acess_token"]

        request = conn(:post,"/api/accounts")
                    |> put_req_header("authorization", "Bearer #{access_token}")

        response = ApiBanking.Router.call(request,[])
        assert response.status == 422

    end

end