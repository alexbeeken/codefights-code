defmodule Zoom do
  @h "#"
  @s " "

  def above(image, x, y) do
    from_coords(image, x, y+1)
  end

  def below(image, x, y) do
    from_coords(image, x, y-1)
  end

  def get_parent(image, x, y) do
    from_coords(image, round(Float.floor(x / 2)), round(Float.floor(y / 2)))
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
    case Enum.fetch(image, y) do
      { :ok, row } ->
        case Enum.fetch(row, x) do
          { :ok, char } ->
            char
          :error ->
            nil
        end
      :error ->
        nil
    end
  end

  def get_new_char(original, x, y) do
    parentx = parent(x)
    parenty = parent(y)
    parent = get_parent(original, parentx, parenty)
    if parent == @s do
      x = rem(x, 2)
      y = rem(y, 2)
      above = above(original, parentx, parenty)
      below = below(original, parentx, parenty)
      right = right(original, parentx, parenty)
      left = left(original, parentx, parenty)
      case { x, y } do
        { 0, 0 } ->
          if (above == @h && left == @h) do
            @h
          else
            @s
          end
        { 0, 1 } ->
          if (below == @h && left == @h) do
            @h
          else
            @s
          end
        { 1, 0 } ->
          if (above == @h && right == @h) do
            @h
          else
            @s
          end
        { 1, 1 } ->
          if (below == @h && right == @h) do
            @h
          else
            @s
          end
      end
    else
      @h
    end
  end

  def left(image, x, y) do
    from_coords(image, x-1, y)
  end

  def next_x(original, x) do
    rem((x + 1), (width(original) * 2))
  end

  def parent(coord) do
    div(coord, 2)
  end

  def populate_blanks([ h | t ], original, x, y) do
    [ populate_row(h, original, 0, y) | populate_blanks(t, original, 0, y + 1) ]
  end

  def populate_blanks([], original, x, y) do
    []
  end

  def populate_row([ h | t ], original, x, y) do
    parent = get_parent(original, x, y)
    new_char = get_new_char(original, x, y)
    x = next_x(original, x)
    [ new_char | populate_row(t, original, x, y) ]
  end

  def populate_row([], original, x, y) do
    []
  end

  def right(image, x, y) do
    from_coords(image, x+1, y)
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
