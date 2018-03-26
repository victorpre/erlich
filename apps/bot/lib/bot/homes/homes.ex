defmodule Bot.Homes do
  @moduledoc """
  The Homes context.
  """

  import Ecto.Query, warn: false
  alias Db.Repo

  alias Bot.Homes.Ad

  @doc """
  Returns the list of ads.

  ## Examples

      iex> list_ads()
      [%Ad{}, ...]

  """
  def list_ads do
    Repo.all(Ad)
  end

  @doc """
  Gets a single ad by url.

  Raises `Ecto.NoResultsError` if the Ad does not exist.

  ## Examples

      iex> get_ad_by_url("https://www.someurl.com/ads/9123123")
      %Ad{}

      iex> get_ad_by_url("https://www.someurl.com/ads/9123123")
      nil

  """
  def get_ad_by_url(url)  do
    query = from a in Ad, where: a.url == ^url
    Repo.one(query)
  end

  @doc """
  Gets a single ad.

  Raises `Ecto.NoResultsError` if the Ad does not exist.

  ## Examples

      iex> get_ad!(123)
      %Ad{}

      iex> get_ad!(456)
      ** (Ecto.NoResultsError)

  """
  def get_ad!(id), do: Repo.get!(Ad, id)

  @doc """
  Creates a ad.

  ## Examples

      iex> create_ad(%{field: value})
      {:ok, %Ad{}}

      iex> create_ad(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_ad(attrs \\ %{}) do
    %Ad{}
    |> Ad.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a ad.

  ## Examples

      iex> update_ad(ad, %{field: new_value})
      {:ok, %Ad{}}

      iex> update_ad(ad, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_ad(%Ad{} = ad, attrs) do
    ad
    |> Ad.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Ad.

  ## Examples

      iex> delete_ad(ad)
      {:ok, %Ad{}}

      iex> delete_ad(ad)
      {:error, %Ecto.Changeset{}}

  """
  def delete_ad(%Ad{} = ad) do
    Repo.delete(ad)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking ad changes.

  ## Examples

      iex> change_ad(ad)
      %Ecto.Changeset{source: %Ad{}}

  """
  def change_ad(%Ad{} = ad) do
    Ad.changeset(ad, %{})
  end

  @doc """
  Returns an HTML formatted %Ad{} to be returned by the Bot.
  """
  def ad_caption_as_html(ad) do
    "#{ad.title} (#{ad.url})\n" <>
      "Price: #{ad.price}\n" <> "Size: #{ad.size}\n" <> "Provider: #{ad.provider}"
  end
end
