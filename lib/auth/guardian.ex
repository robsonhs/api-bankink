defmodule ApiBanking.Auth.Guardian do
    @moduledoc """
        Provides functions subject_for_token/2 and resource_from_claims/1 to perform the authentication and authorization process
    """    
    use Guardian, otp_app: :api_banking

    
    @spec subject_for_token(atom() | %{id: any()}, any()) :: {:ok, String.t()}
    def subject_for_token(resource, _claims) do
        sub = to_string(resource.id)
        {:ok, sub}
    end

    @spec resource_from_claims(nil | keyword() | map()) :: {:ok, ApiBanking.Credentials.t()}
    def resource_from_claims(claims) do
        credentials = ApiBanking.Repo.User.findByIdCredentials(claims["sub"])
        {:ok, credentials}
    end

end