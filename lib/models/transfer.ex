defmodule ApiBanking.Transfer do
    use Ecto.Schema
    import Ecto.Changeset
    alias ApiBanking.Transfer

    schema "tb_transfer" do
        field(:debit_account, :integer)
        field(:debit_amount, :float)
        field(:favored_bank_code, :string)
        field(:favored_account, :string)
        field(:favored_agency, :string)
        field(:favored_name, :string)
        field(:favored_document, :string)
    end

    def changeset(%Transfer{} = transfer, attrs) do
        transfer
        |> cast(attrs, [:debit_account, :debit_amount, :favored_bank_code, :favored_account, :favored_agency, :favored_name, :favored_document])
        |> validate_required([:debit_account, :debit_amount, :favored_bank_code, :favored_account, :favored_agency, :favored_name, :favored_document])
    end

end