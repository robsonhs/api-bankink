use Mix.Config

config :api_banking, ApiBanking.Repo,
        database: System.get_env("DB_NAME"),
        username: System.get_env("DB_USER"),
        password: System.get_env("DB_PASSWORD"),
        hostname: System.get_env("DB_HOST"),
        port: System.get_env("DB_PORT"),
        pool_size: 10