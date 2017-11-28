require IEx

defmodule StringColumns do
  def num_rows(sorted) do
    row_float = length(sorted) / 3
    row_float
      |> Float.ceil
      |> round
  end

  def num_columns(sorted) do
    case length(sorted) do
      1 -> 1
      2 -> 2
      true -> 3
    end
  end

  def reconstruct([ h | t ]) do
    if t != [] do
      Enum.join(h, " ") <> "\n" <> reconstruct(t)
    else
      Enum.join(h, " ")
    end
  end

  def reconstruct(_) do "" end

  def arrange(sorted, num_rows, index_offset \\ 0) do
    if index_offset < num_rows do
      { _offset, offset_sorted } = Enum.split(sorted, index_offset)
      [ Enum.take_every(offset_sorted, num_rows) | arrange(sorted, num_rows, index_offset + 1) ]
    else
      []
    end
  end

  def stringColumns(words) do
    sorted =
      words
      |> String.split(" ")
      |> Enum.sort

    num_rows = num_rows(sorted)

    cond do
      length(sorted) == 4 ->
        [ a, b, c, d ] = sorted
        "#{a} #{c} #{d}\n#{b}"
      num_rows == 1 ->
        Enum.join(sorted, " ")
      true ->
        sorted
          |> arrange(num_rows)
          |> reconstruct
    end
  end
end

# IO.inspect StringColumns.stringColumns("a b c d e f g h i")
# IO.puts StringColumns.stringColumns("a b c d e f g h i") == "a d g\nb e h\nc f i"
# IO.inspect StringColumns.stringColumns("a b c d e f g h")
# IO.puts StringColumns.stringColumns("a b c d e f g h") == "a d g\nb e h\nc f"
IO.inspect StringColumns.stringColumns("a")
IO.inspect StringColumns.stringColumns("a b")
IO.inspect StringColumns.stringColumns("a b c")
IO.inspect StringColumns.stringColumns("a b c d")
IO.inspect StringColumns.stringColumns("a b c d e")
IO.inspect StringColumns.stringColumns("a b c d e f")
IO.inspect StringColumns.stringColumns("a b c d e f g")
IO.inspect StringColumns.stringColumns("a b c d e f g h")
IO.inspect StringColumns.stringColumns("a b c d e f g h i")
# IO.puts StringColumns.stringColumns("a b c d") == "a c d\nb"
# IO.inspect StringColumns.stringColumns("a b c")
