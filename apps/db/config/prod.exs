use Mix.Config

config :db, Db.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "erlich_user",
  database: "erlich_prod",
  hostname: "localhost",
  pool_size: 20
