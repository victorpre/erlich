defmodule Db.ReleaseTasks do
  def migrate do
    {:ok, _} = Application.ensure_all_started(:db)

    path = Application.app_dir(:db, "priv/repo/migrations")

    Ecto.Migrator.run(Db.Repo, path, :up, all: true)

    :init.stop()
  end
end
