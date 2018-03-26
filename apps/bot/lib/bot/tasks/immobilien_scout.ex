defmodule Bot.Tasks.ImmobilienScout do
  require Logger

  alias Crawler.ImmobilienScout
  alias Bot.Homes

  def import_ads(page \\ 1) do
    Logger.info("Checking ImmobilienScout for updates...")
    case ImmobilienScout.import(page) do
      [] ->
        :stop
      entries ->
        new_entries = process_entries(entries)

        if (length(new_entries) > 0) do
          # notify_subscribers(new_entries)
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
      nil -> Homes.create_ad(entry)
      _other -> nil
    end
  end
end