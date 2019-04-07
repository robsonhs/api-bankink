defmodule ApiBanking.Auth.Guardian do
    use Guardian, otp_app: :api_banking

    def subject_for_token(resource, _claims) do
        IO.puts("subject_for_token")
        IO.inspect(resource)
        sub = to_string(resource.id)
        IO.inspect(sub)
        {:ok, sub}
    end

    def resource_from_claims(claims) do
        IO.puts("resource_from_claims")
        IO.inspect(claims)
        credentials = ApiBanking.Repo.User.findByIdCredentials(claims["sub"])
        {:ok, credentials}
    end

end