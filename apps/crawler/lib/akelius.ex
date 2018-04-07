defmodule Crawler.Akelius do
  def import(page \\ 1) do
    url = "https://www.akelius.de/en/search/apartments/norden/hamburg/list?region=all"

    url
    |> get_page_html()
    |> get_dom_elements()
    |> extract_metadata()
  end

  defp get_page_html(url) do
    %HTTPoison.Response{body: body} = HTTPoison.get!(url, [], follow_redirect: true)
    body
  end

  defp get_dom_elements(body) do
    Floki.find(body, "li.no-border > figure")
  end

  defp extract_metadata(elements) do
    Enum.map(elements, fn {"figure", attrs, content} ->
      %{
        title: title(content),
        url: url(content),
        price: price(content),
        size: size(content),
        img: image(content),
        provider: "Akelius"
      }
    end)
  end

  defp title(html) do
    [{"h3", _attribs, title}] = Floki.find(html, "figcaption h3")

    title
    |> Enum.take_every(2)
    |> Enum.map(fn x -> String.trim(x) end)
    |> Enum.join(", ")
  end

  defp url(html) do
    [{"a", [{"href", url} | _params], _other_params}] = Floki.find(html, "a")
    "https://www.akelius.de" <> url
  end

  defp price(html) do
    [{_, _, [price]}] = Floki.find(html, "p span.price")
    price
  end

  defp size(html) do
    [{_, _, [size]}] = Floki.find(html, "p span.areaSize")
    size
  end

  defp image(html) do
    [{"div", [_, {"style", img_asset}], _}] = Floki.find(html, ".image-box")
    String.slice(img_asset, 22..-2)
  end
end
