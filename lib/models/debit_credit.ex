defmodule ApiBanking.DebitCredit do
    use Ecto.Schema
    import Ecto.Changeset
    alias ApiBanking.DebitCredit

    schema "tb_movements" do
        field(:number_account, :integer)
        field(:amount, :float)
        field(:operation_type, :string)
    end

    def changeset(%DebitCredit{} = debit, attrs) do
        debit
        |> cast(attrs, [:account, :amount, :operation_type])
        |> validate_required([:account, :amount, :operation_type])
    end

end