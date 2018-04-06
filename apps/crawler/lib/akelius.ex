defmodule Crawler.Akelius do

  def import(page \\ 1) do
    url = "https://www.akelius.de/en/search/apartments/norden/hamburg/list?region=all"

    url
    |> get_page_html()
    |> get_dom_elements()
    |> filter_ads()
    # |> extract_metadata()
  end

  defp get_page_html(url) do
    %HTTPoison.Response{body: body} = HTTPoison.get!(url, [], follow_redirect: true)
    body
  end

  defp get_dom_elements(body) do
  end

  defp filter_ads(elements) do
  end
end
