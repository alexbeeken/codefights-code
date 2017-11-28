require IEx

defmodule StringColumns do
  def new_row(columns, index) do
    [ col1, col2, col3 ] = columns
    col1_word = Enum.at(col1, index)
    col2_word = Enum.at(col2, index)
    col3_word = Enum.at(col3, index)
    new_row = [ col1_word, col2_word, col3_word ]
    new_row = Enum.filter(new_row, & !is_nil(&1))
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
      [ col1, col2, col3 ] = columns
      col1_word = Enum.at(col1, current_row_idx)
      col2_word = Enum.at(col2, current_row_idx)
      col3_word = Enum.at(col3, current_row_idx)
      new_row = [ col1_word, col2_word, col3_word ]
      new_row = Enum.filter(new_row, & !is_nil(&1))
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
