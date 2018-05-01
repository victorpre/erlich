defmodule Bot.RecipientsTest do

  use ExUnit.Case, async: true
  alias Bot.Recipients

  describe "subscribers" do
    alias Bot.Recipients.Subscriber
    setup do
      # Explicitly get a connection before each test
      :ok = Ecto.Adapters.SQL.Sandbox.checkout(Db.Repo)
    end

    @valid_attrs %{subscriber_id: 42}
    @update_attrs %{subscriber_id: 43}
    @invalid_attrs %{subscriber_id: nil}

    def subscriber_fixture(attrs \\ %{}) do
      {:ok, subscriber} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Recipients.create_subscriber()

      subscriber
    end

    test "list_subscribers/0 returns all subscribers" do
      subscriber = subscriber_fixture()
      assert Recipients.list_subscribers() == [subscriber]
    end

    test "get_subscriber!/1 returns the subscriber with given id" do
      subscriber = subscriber_fixture()
      assert Recipients.get_subscriber!(subscriber.id) == subscriber
    end

    test "create_subscriber/1 with valid data creates a subscriber" do
      assert {:ok, %Subscriber{} = subscriber} = Recipients.create_subscriber(@valid_attrs)
      assert subscriber.subscriber_id == 42
    end

    test "create_subscriber/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Recipients.create_subscriber(@invalid_attrs)
    end

    test "update_subscriber/2 with valid data updates the subscriber" do
      subscriber = subscriber_fixture()
      assert {:ok, subscriber} = Recipients.update_subscriber(subscriber, @update_attrs)
      assert %Subscriber{} = subscriber
      assert subscriber.subscriber_id == 43
    end

    test "update_subscriber/2 with invalid data returns error changeset" do
      subscriber = subscriber_fixture()
      assert {:error, %Ecto.Changeset{}} = Recipients.update_subscriber(subscriber, @invalid_attrs)
      assert subscriber == Recipients.get_subscriber!(subscriber.id)
    end

    test "delete_subscriber/1 deletes the subscriber" do
      subscriber = subscriber_fixture()
      assert {:ok, %Subscriber{}} = Recipients.delete_subscriber(subscriber)
      assert_raise Ecto.NoResultsError, fn -> Recipients.get_subscriber!(subscriber.id) end
    end

    test "change_subscriber/1 returns a subscriber changeset" do
      subscriber = subscriber_fixture()
      assert %Ecto.Changeset{} = Recipients.change_subscriber(subscriber)
    end
  end
end
