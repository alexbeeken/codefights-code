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

  # def reconstruct([ h | t], output) do
  #   [ first | others ] = h
  #   [ tops | bottoms ] = rotate()
  #
  # end

  def slice(array, height, width) do
    slice_y(array, height, width, 0)
  end

  def slice_y(array, height, width, row) do
    start = 0 + (row * width)
    ending = ((row + 1) * width) - 1
    if ((start >= width * height)) do
      array
    else
      [ Enum.slice(array, start..ending) | slice_y(array, height, width, row + 1) ]
    end
  end

  def slice_y([], _width) do
    []
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
    # |> reconstruct
  end
end

test1 = [
  "   ",
  "  #",
  " # ",
  "   "
]

IO.inspect Zoom.zoom(test1)
