defmodule ApiBanking.Debit do
    use Ecto.Schema
    import Ecto.Changeset
    alias ApiBanking.Debit

    schema "tb_debit" do
        field(:account, :integer)
        field(:amount, :float)
        field(:operation_type, :string)
    end

    def changeset(%Debit{} = debit, attrs) do
        debit
        |> cast(attrs, [:account, :amount, :operation_type])
        |> validate_required([:account, :amount, :operation_type])
    end

end