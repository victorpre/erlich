use Mix.Config

config :db,
  ecto_repos: [Db.Repo],
  adapter: Ecto.Adapters.Postgres
