# CURL request for manually finding example data
#
# curl "https://www.googleapis.com/youtube/v3/channels?part=snippet&key=AIzaSyAFFjaQ_9qfd6Ecm7JbskXagb-pu1FdvIE&id=UCtZ04kW3xThhfO4PCfvGaNQ,UC6nSFpj9HTCZ5t-N3Rm3-HA"
require IEx

defmodule MostActiveYoutubeChannel do
  def count_uniqs([h | t], titles) do
    [ occurences(h, titles) | count_uniqs(t, titles) ]
  end

  def occurences(title, titles) do
    titles
    |> Enum.map(&(&1 == title))
    |> Enum.filter(&(&1))
    |> length
  end

  def count_uniqs([], _) do
    []
  end

  def decode(raw) do
    cleaned =
      raw
      |> String.replace("\n", "")
      |> String.replace(~s(\"), "")
      |> String.replace(~s("), "")

    ~r/channelTitle: (.*?),/
    |> Regex.scan(cleaned)
    |> Enum.map(&(Enum.at(&1, 1)))
  end

  def max_titles(uniqs, counts, max, index) do
    cond do
      index > length(uniqs) ->
        []
      Enum.at(counts, index) == max ->
        [ Enum.at(uniqs, index) | max_titles(uniqs, counts, max, index + 1) ]
      true ->
        [ max_titles(uniqs, counts, max, index + 1) ]
    end
  end

  def mostActiveYoutubeChannel(videoIDs) do
    argument = "https://www.googleapis.com/youtube/v3/videos?part=snippet&key=HIDEY_HO&id=" <> Enum.join(videoIDs, ",")
    { response, _ } = System.cmd("curl", [argument])
    titles = decode(response)
    uniqs = Enum.uniq(titles)
    counts = count_uniqs(uniqs, titles)
    max = Enum.max(counts)
    max_titles = List.flatten(max_titles(uniqs, counts, max, 0))
    cond do
      length(max_titles) == 0 ->
        ""
      true ->
        Enum.min(max_titles)
    end
  end
end

IO.inspect MostActiveYoutubeChannel.mostActiveYoutubeChannel(["Rd9ZKwNCYtM", "YQJKgtAktLQ", "VL0eeXONpOs", "YaK8J0cxL8c", "JcAWr4gZgeI"])
