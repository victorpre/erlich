defmodule Crawler.WgGesucht do

  def import(page \\ 1) do
    url = "https://www.wg-gesucht.de/wohnungen-in-Hamburg.55.2.1.0.html?offer_filter=1&noDeact=1&city_id=55&category=2&rent_type=2&rMax=750"

    url
    # |> get_page_html()
    # |> get_dom_elements()
    # |> extract_metadata()
  end

  defp get_page_html(url) do
    %HTTPoison.Response{body: body} = HTTPoison.get!(url, [], follow_redirect: true)
    body
  end
end
