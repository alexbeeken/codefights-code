defmodule Zoom do
  def above(image, x, y) do
    from_coords(image, x, y-1)
  end

  def below(image, x, y) do
    from_coords(image, x, y+1)
  end

  def get_parent(image, x, y) do
    from_coords(image, parent(x), parent(y))
  end

  def expand_blank(image) do
    List.duplicate(
      List.duplicate(
        " ",
        width(image) * 2
      ),
      height(image) * 2
    )
  end

  def from_coords(image, x, y) do
    if (x >= 0 && y >= 0 && x < width(image) && y < height(image) ) do
      case Enum.fetch(image, y) do
        { :ok, row } ->
          case Enum.fetch(row, x) do
            { :ok, char } ->
              char
            :error ->
              " "
          end
        :error ->
          " "
      end
    else
      " "
    end
  end

  def get_new_char(original, absx, absy) do
    parentx = parent(absx)
    parenty = parent(absy)
    parent_char = get_parent(original, absx, absy)
    if parent_char == " " do
      x = rem(absx, 2)
      y = rem(absy, 2)
      above = above(original, parentx, parenty)
      below = below(original, parentx, parenty)
      right = right(original, parentx, parenty)
      left = left(original, parentx, parenty)
      case { x, y, above, below, left, right } do
        { 0, 0, "#", _, "#", _ } ->
          "#"
        { 0, 1, _, "#", "#", _ } ->
          "#"
        { 1, 0, "#", _, _, "#" } ->
          "#"
        { 1, 1, _, "#", _, "#" } ->
          "#"
        _ ->
          " "
      end
    else
      "#"
    end
  end

  def left(image, x, y) do
    from_coords(image, x-1, y)
  end

  def next_x(original, x) do
    rem((x + 1), (width(original) * 2))
  end

  def parent(coord) do
    round(Float.floor(coord / 2))
  end

  def populate_blanks([ h | t ], original, y) do
    [ populate_row(h, original, 0, y) | populate_blanks(t, original, y + 1) ]
  end

  def populate_blanks([], _original, _y) do
    []
  end

  def populate_row([ _h | t ], original, x, y) do
    new_char = get_new_char(original, x, y)
    x = next_x(original, x)
    [ new_char | populate_row(t, original, x, y) ]
  end

  def populate_row([], _original, _x, _y) do
    []
  end

  def right(image, x, y) do
    from_coords(image, x+1, y)
  end

  def row_join([ h | t ]) do
    [ Enum.join(h) | row_join(t) ]
  end

  def row_join([]) do
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
    row_join(populate_blanks(blanks, image, 0))
  end
end

test1 = [
  "# ",
  " #"
]

IO.inspect Zoom.zoom(test1)
