# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

config :api_banking,
         ecto_repos: [ApiBanking.Repo]

config :api_banking, ApiBanking.Repo,
  database: "api_banking",
  username: "postgres",
  password: "mysecretpassword",
  hostname: "localhost"

  config :api_banking, Guardian,
    allowed_algos: ["HS512"],
    verify_module: Guardian.JWT,
    issuer: "api_banking",
    ttl: { 1, :days },
    allowed_drift: 2000,
    verify_issuer: true,
    secret_key: %{
      "alg" => "ES512",
      "crv" => "P-521",
      "d" => "soEDCt7wqYp8Cifxkw5yVF2bsrDHhCK5ft4ja1GbrDRBWtsQE0Y0heUXs2fZp7jm-boVL4V6K9dB_t0Y5Zxyjgk",
      "kty" => "EC",
      "use" => "sig",
      "x" => "AArBU-F9ErtoqwFcUJx7Bofb4JJX2AK5zp7m62GcNryILhRn3t-wStzNFEuSizw7Ta_cmkIxRA_5onMve4J9lkpq",
      "y" => "AWgskACOts9kb664wjonu4xwZe1PsaTvpLT9CM64uUZGvQuMhckqS7_SWT68DSIagiCFXw1fJG6uXGDL8H78W8yL"
    },
    serializer: ApiBanking.Auth.Guardian

# This configuration is loaded before any dependency and is restricted
# to this project. If another project depends on this project, this
# file won't be loaded nor affect the parent project. For this reason,
# if you want to provide default values for your application for
# third-party users, it should be done in your "mix.exs" file.

# You can configure your application as:
#
#     config :api_banking, key: :value
#
# and access this configuration in your application as:
#
#     Application.get_env(:api_banking, :key)
#
# You can also configure a third-party app:
#
#     config :logger, level: :info
#

# It is also possible to import configuration files, relative to this
# directory. For example, you can emulate configuration per environment
# by uncommenting the line below and defining dev.exs, test.exs and such.
# Configuration from the imported file will override the ones defined
# here (which is why it is important to import them last).
#
#     import_config "#{Mix.env()}.exs"
