defmodule Zoom do
  def expand([ h | t ], reference) do
    square =
      case h do
        "#" -> [["#", "#"],["#","#"]]
        " " -> [[" ", " "],[" "," "]]
      end
    [ square | expand(t, reference) ]
  end

  def expand([], _reference) do
    []
  end

  def slice(array, height, width) do
    Enum.chunk_every(array, width)
  end

  def split([ h | t ]) do
    [ String.split(h, ~r//, trim: true) | split(t) ]
  end

  def split([]) do
    []
  end

  def width(image) do
    {:ok, row } = Enum.fetch(image, 0)
    String.length(row)
  end

  def zoom(image) do
    flat =
      image
      |> split
      |> List.flatten

    flat
    |> expand(flat)
    |> slice(0, width(image))
  end
end

test1 = [
  "   ",
  "  #",
  " # ",
  "   "
]

IO.inspect Zoom.zoom(test1)
