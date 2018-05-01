use Mix.Config

config :db, Db.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "erlich_user",
  database: "erlich_prod",
  hostname: "localhost",
  port: 5432,
  pool_size: 20

import_config "../../../config/prod.secret.exs"
