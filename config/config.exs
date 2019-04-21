# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

config :api_banking,
        ecto_repos: [ApiBanking.Repo]

config :api_banking, ApiBanking.Repo,
    database: System.get_env("DB_NAME"),
    username: System.get_env("DB_USER"),
    password: System.get_env("DB_PASSWORD"),
    hostname: System.get_env("DB_HOST"),
    port: System.get_env("DB_PORT"),
    pool_size: 10

config :api_banking, ApiBanking.Auth.Guardian,
  allowed_algos: ["HS512"],
  verify_module: Guardian.JWT,
  issuer: "api_banking",
  ttl: { 1, :days },
  allowed_drift: 2000,
  verify_issuer: true,
  secret_key: %{
    "alg" => "HS512",
    "k" => "eiQQEh0vyYhHjfl00BbCLJO8w2SYTnf-Thp5s9miefOufUhfBa9KzH0vNJ3AzFVyZe8UI-a4S8lzprw40gpTYA",
    "kty" => "oct",
    "use" => "sig"
  }
