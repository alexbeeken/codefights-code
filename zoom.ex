defmodule Zoom do
  @h "#"
  @s " "

  def get_parent(image, x, y) do
    from_coords(image, div(x, 2), div(y, 2))
  end

  def expand_blank(image) do
    List.duplicate(
      List.duplicate(
        @s,
        width(image) * 2
      ),
      height(image) * 2
    )
  end

  def from_coords(image, x, y) do
    { :ok, row } = Enum.fetch(image, y)
    { :ok, char } = Enum.fetch(row, x)
    char
  end

  def next_x(original, x) do
    rem((x + 1), (width(original) * 2))
  end

  def populate_blanks([ h | t ], original, x, y) do
    [ populate_row(h, original, 0, y) | populate_blanks(t, original, 0, y + 1) ]
  end

  def populate_blanks([], original, x, y) do
    []
  end

  def populate_row([ h | t ], original, x, y) do
    parent = get_parent(original, x, y)
    new_char = if (parent == @h) do
                 @h
               else
                 @s
               end
    x = next_x(original, x)
    [ new_char | populate_row(t, original, x, y) ]
  end

  def populate_row([], original, x, y) do
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
    length(row)
  end

  def height(image) do
    length(image)
  end

  def zoom(image) do
    image = split(image)
    blanks = expand_blank(image)
    populate_blanks(blanks, image, 0, 0)
  end
end

test1 = [
  "   ",
  "  #",
  " # ",
  "   "
]

IO.inspect Zoom.zoom(test1)
