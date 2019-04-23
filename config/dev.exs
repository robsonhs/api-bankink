use Mix.Config

config :api_banking, ApiBanking.Repo,
        database: "api_banking",
        username: "apibanking",
        password: "apibanking",
        hostname: "localhost",
        port: 5432,
        pool_size: 10