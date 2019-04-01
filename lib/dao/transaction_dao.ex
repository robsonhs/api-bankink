defmodule ApiBanking.TransactionDAO do

    def insertCredit do

        response = Ecto.Adapters.SQL.query!(ApiBanking.Repo, "select perform_credit::bigint from perform_credit(6564860, 23000.44, 'c')")
        hd(hd(response.rows))

    end

end 