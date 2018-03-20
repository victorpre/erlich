use Mix.Config

config :db, Db.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "erlich_dev",
  username: "postgres",
  password: "postgres",
  hostname: "localhost"
  pool_size: 10
