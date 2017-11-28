require IEx

defmodule StringColumns do
  def new_row(columns, index) do
    columns
      |> Enum.map(& Enum.at &1, index )
      |> Enum.filter(& !is_nil &1 )
  end

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
      x -> 3
    end
  end

  def reconstruct([ h | t ]) do
    if length(h) == 3 && t != [] do
      Enum.join(h, " ") <> "\n" <> reconstruct(t)
    else
      Enum.join(h, " ")
    end
  end

  def reconstruct(_) do "" end

  def rotate(columns, num_rows, current_row_idx, output) do
    if current_row_idx < num_rows do
      new_row = new_row(columns, current_row_idx)
      output = List.insert_at(output, current_row_idx, new_row)
      rotate(columns, num_rows, current_row_idx + 1, output)
    else
      output
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
          |> Enum.chunk_every(num_rows)
          |> rotate(num_rows, 0, [])
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
# IO.puts StringColumns.stringColumns("a b c d") == "a c d\nb"
# IO.inspect StringColumns.stringColumns("a b c")
IO.inspect StringColumns.num_columns(["a"])
IO.inspect StringColumns.num_columns(["a", "b"])
IO.inspect StringColumns.num_columns(["a", "b", "c"])
IO.inspect StringColumns.num_columns(["a", "b", "c", "d"])
IO.inspect StringColumns.num_columns(["a", "b", "c", "a", "b", "c", "d"])
