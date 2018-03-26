defmodule Bot.Recipients.Subscriber do
  use Ecto.Schema
  import Ecto.Changeset


  schema "subscribers" do
    field :subscriber_id, :integer

    timestamps()
  end

  @doc false
  def changeset(subscriber, attrs) do
    subscriber
    |> cast(attrs, [:subscriber_id])
    |> validate_required([:subscriber_id])
  end
end
