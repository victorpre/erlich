defmodule Crawler.ImmoWelt do

  def import(page \\ 1) do
    url =
      "https://www.immowelt.de/liste/hamburg-altona-altstadt/wohnungen/mieten?geoid=10802001000005%2C10802004000015%2C10802003000023%2C10802005000025%2C10802004000030%2C10802004000032%2C10802003000039%2C10802005000042%2C10802003000043%2C10802005000044%2C10802001000074%2C10802003000081%2C10802004000086%2C10802004000087%2C10802003000090%2C10802001000088%2C10802005000094&roomi=2&prima=750&sort=relevanz&cp=#{
        page
      }"

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
    Floki.find(body, "div.iw_list_content div.listitem_wrap")
  end

  defp extract_metadata(elements) do
    Enum.map(elements, fn {"div", attrs, content} ->
      %{
        title: title(content),
        url: url(content),
        price: price(content),
        size: size(content),
        img: image(content),
        provider: "ImmoWelt"
      }
    end)
  end

  defp title(html) do
    [{"h2", [attribs], [title]}] = Floki.find(html, "div.listcontent h2.ellipsis")
    title
  end

  def url(html) do
    [{"a", [{"href", url} | _params], _other_params}] = Floki.find(html, "div.listitem > a")
    "https://www.immowelt.de" <> url
  end

  defp price(html) do
    [{"strong", _attribs, [price]} | _rest] =
      Floki.find(html, "div.listconten_offset div.hardfacts_3 div.hardfact > strong")

    String.trim(price)
  end

  defp size(html) do
    [_h | t] = Floki.find(html, "div.listconten_offset div.hardfacts_3 div.hardfact")
    [{"div", _classes, [size, _attribs]}, _other] = t
    String.trim(size)
  end

  defp image(html) do
    img_tag = Floki.find(html, "div.img_center picture img")
    extract_img_src(img_tag)
  end

  defp extract_img_src([{"img", [_l, _alt, _title, _class, {"data-srcset", image}], []}]), do: image
  defp extract_img_src(img_tag), do: "http://res.cloudinary.com/victorpre/image/upload/v1522101065/Erlich/no-picture.png"
end
