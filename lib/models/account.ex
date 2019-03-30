defmodule ApiBanking.Account do
  use Ecto.Schema
  import Ecto.Changeset 
  alias ApiBanking.Account

  @primary_key {:number_account,  :integer, autogenerate: false}

  schema "tb_account" do
    field(:name_holder, :string)
    field(:document_holder, :string)
    field(:balance, :float)
  end

  def changeset(%Account{} = account, attrs) do
    account
    |> cast(attrs, [:number_account, :name_holder, :document_holder, :balance])
    |> validate_required([:number_account,:balance])
  end

end
