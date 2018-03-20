use Mix.Config

config :db, Db.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "erlich_test",
  username: "postgres",
  password: "postgres",
  hostname: "localhost"

config :logger,
  backends: [:console],
  compile_time_purge_level: :debug
