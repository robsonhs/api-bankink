defmodule ApiBanking.User do
    use Ecto.Schema
    import Ecto.Changeset 
    alias ApiBanking.User
  
    @primary_key {:username, :string, autogenerate: false}
  
    schema "tb_user" do
      field(:password, :string)
      field(:email, :string)
    end
  
    def changeset(%User{} = user, attrs) do
        user
      |> cast(attrs, [:username, :password, :name, :email])
      |> validate_required([:username, :password, :name, :email])
    end
  
  end