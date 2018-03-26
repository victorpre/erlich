defmodule Bot.Repo.Migrations.CreateAds do
  use Ecto.Migration

  def change do
    create table(:ads) do
      add :provider, :string
      add :title, :string
      add :url, :string
      add :price, :string
      add :size, :string
      add :img, :text

      timestamps()
    end

    create unique_index(:ads, [:url])
  end
end
