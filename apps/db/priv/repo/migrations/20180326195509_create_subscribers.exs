defmodule Bot.Repo.Migrations.CreateSubscribers do
  use Ecto.Migration

  def change do
    create table(:subscribers) do
      add :subscriber_id, :integer

      timestamps()
    end

    create unique_index(:subscribers, [:subscriber_id])
  end
end
