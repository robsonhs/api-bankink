defmodule ApiBanking.Auth.Guardian do
    use Guardian, otp_app: :api_banking

    def subject_for_token(resource, _claims) do
        sub = to_string(resource.id)
        {:ok, sub}
    end

    def resource_from_claims(claims) do
        credentials = ApiBanking.Repo.User.findByIdCredentials(claims["sub"])
        {:ok, credentials}
    end

end