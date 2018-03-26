defmodule Bot.HomesTest do

  use ExUnit.Case, async: true
  alias Bot.Homes

  describe "ads" do

    alias Bot.Homes.Ad
    setup do
      # Explicitly get a connection before each test
      :ok = Ecto.Adapters.SQL.Sandbox.checkout(Db.Repo)
    end


    @valid_attrs %{img: "some img", price: "some price", provider: "some provider", size: "some size", title: "some title", url: "some url"}
    @update_attrs %{img: "some updated img", price: "some updated price", provider: "some updated provider", size: "some updated size", title: "some updated title", url: "some updated url"}
    @invalid_attrs %{img: nil, price: nil, provider: nil, size: nil, title: nil, url: nil}

    def ad_fixture(attrs \\ %{}) do
      {:ok, ad} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Homes.create_ad()

      ad
    end

    test "list_ads/0 returns all ads" do
      ad = ad_fixture()
      assert Homes.list_ads() == [ad]
    end

    test "get_ad!/1 returns the ad with given id" do
      ad = ad_fixture()
      assert Homes.get_ad!(ad.id) == ad
    end

    test "create_ad/1 with valid data creates a ad" do
      assert {:ok, %Ad{} = ad} = Homes.create_ad(@valid_attrs)
      assert ad.img == "some img"
      assert ad.price == "some price"
      assert ad.provider == "some provider"
      assert ad.size == "some size"
      assert ad.title == "some title"
      assert ad.url == "some url"
    end

    test "create_ad/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Homes.create_ad(@invalid_attrs)
    end

    test "update_ad/2 with valid data updates the ad" do
      ad = ad_fixture()
      assert {:ok, ad} = Homes.update_ad(ad, @update_attrs)
      assert %Ad{} = ad
      assert ad.img == "some updated img"
      assert ad.price == "some updated price"
      assert ad.provider == "some updated provider"
      assert ad.size == "some updated size"
      assert ad.title == "some updated title"
      assert ad.url == "some updated url"
    end

    test "update_ad/2 with invalid data returns error changeset" do
      ad = ad_fixture()
      assert {:error, %Ecto.Changeset{}} = Homes.update_ad(ad, @invalid_attrs)
      assert ad == Homes.get_ad!(ad.id)
    end

    test "delete_ad/1 deletes the ad" do
      ad = ad_fixture()
      assert {:ok, %Ad{}} = Homes.delete_ad(ad)
      assert_raise Ecto.NoResultsError, fn -> Homes.get_ad!(ad.id) end
    end

    test "change_ad/1 returns a ad changeset" do
      ad = ad_fixture()
      assert %Ecto.Changeset{} = Homes.change_ad(ad)
    end
  end
end
