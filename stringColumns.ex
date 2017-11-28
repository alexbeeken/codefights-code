require IEx

defmodule StringColumns do
  def num_rows(sorted) do
    sorted
      |> length
      |> Kernel./(3)
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
    Enum.join(h, " ") <> if t != [], do: "\n#{reconstruct(t)}", else: ""
  end

  def arrange(sorted, index_offset \\ 0) do
    num_rows = num_rows(sorted)
    if index_offset < num_rows do
      row =
        sorted
        |> Enum.slice(index_offset..-1)
        |> Enum.take_every(num_rows)
      [ row | arrange(sorted, index_offset + 1) ]
    else
      []
    end
  end

  def stringColumns(words) do
    words
    |> String.split(" ")
    |> Enum.sort
    |> arrange
    |> reconstruct
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
