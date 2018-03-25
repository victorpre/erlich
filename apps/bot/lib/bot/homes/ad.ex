defmodule Bot.Homes.Ad do
  use Ecto.Schema
  import Ecto.Changeset


  schema "ads" do
    field :img, :string
    field :price, :string
    field :provider, :string
    field :size, :string
    field :title, :string
    field :url, :string

    timestamps()
  end

  @doc false
  def changeset(ad, attrs) do
    ad
    |> cast(attrs, [:provider, :title, :url, :price, :size, :img])
    |> validate_required([:provider, :title, :url, :price, :size, :img])
    |> unique_constraint(:url, message: "ad already added.")
  end
end
