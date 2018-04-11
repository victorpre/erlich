defmodule Bot.Tasks.Akelius do
  require Logger

  alias Crawler.Akelius
  alias Bot.Homes
  alias Bot.Recipients

  def import_ads(page \\ 1) do
    Logger.info("Checking Akelius for updates...")
    case Akelius.import(page) do
      [] ->
        :stop
      entries ->
        new_entries = process_entries(entries)

        if (length(new_entries) > 0) do
          notify_subscribers(new_entries)
          import_ads(page + 1)
        end
    end
  end

  defp process_entries(entries) do
    entries
    |> Enum.map(&insert_entry/1)
    |> Enum.filter(fn x -> x != nil end)
  end

  defp insert_entry(entry) do
    case Homes.get_ad_by_url(entry.url) do
      nil -> Homes.create_ad!(entry)
      _other -> nil
    end
  end

  defp notify_subscribers(ads) do
    subscribers = Recipients.list_subscribers()

    Enum.each(ads, fn ad ->
      Enum.each(subscribers, fn x ->
        Recipients.notify_subscriber(x, ad)
      end)
    end)
  end
end
