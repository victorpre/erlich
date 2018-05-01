defmodule Crawler.ImmobilienScout do

  def import(page \\ 1) do
    url = "https://www.immobilienscout24.de/Suche/S-T/P-#{page}/Wohnung-Miete/Fahrzeitsuche/Hamburg_2dNeustadt/20354/-772/2620634/Dammtorstra_dfe/-/30/1,50-/-/EURO--750,00"

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
    Floki.find(body, "#resultListItems > .result-list__listing > div > article")
  end

  defp extract_metadata(elements) do
    Enum.map(elements, fn {"article", attrs, content} ->
      %{
        title: title(content),
        url: url(content),
        price: price(content),
        size: size(content),
        img: image(content),
        provider: "ImmobilienScout"
       }
    end)
  end

  defp title(html) do
    [{"h5", [attribs], title}] = Floki.find(html, ".result-list-entry__brand-title")
    extract_title(title)
  end

  defp extract_title([_newtag, title] = html), do: title
  defp extract_title([title] = html), do: title

  def url(html) do
    [{"a", [{"href", url} | _params ], _other_params }] = Floki.find(html, ".result-list-entry__brand-title-container")
    "https://www.immobilienscout24.de"<>url
  end

  defp price(html) do
    [{"dd", _attribs, [price]} | _rest ] = Floki.find(html, ".grid-item.result-list-entry__primary-criterion > dd")
    price
  end

  defp size(html) do
    [_price , {"dd", _attribs, [size]} | _rest] = Floki.find(html, ".grid-item.result-list-entry__primary-criterion > dd")
    size
  end

  defp image(html) do
    img_tag = Floki.find(html, "div.gallery-container a:first-child img")
    extract_img_src(img_tag)
  end

  defp extract_img_src([{"img",[_,src,_],[]}] = img_tag), do: extract_img(src)
  defp extract_img_src(img_tag), do: "http://res.cloudinary.com/victorpre/image/upload/v1522101065/Erlich/no-picture.png"

  defp extract_img({"src", img} = img_tag), do: img
  defp extract_img({"data-lazy-src", img} = img_tag), do: img
end
