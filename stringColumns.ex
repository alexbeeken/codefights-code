require IEx

defmodule StringColumns do
  def spaces(int) do
    if int > 0 do
      " " <> spaces(int - 1)
    else
      ""
    end
  end

  def add_space(word, min) do
    num_spaces = min - String.length(word)
    word <> spaces(num_spaces)
  end

  def add_spaces([h | t], min_cols, index) do
    [ add_space(h, Enum.at(min_cols, index))
      | add_spaces(t, min_cols, index + 1) ]
  end

  def add_spaces([], _min_cols, _index) do
    []
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

  def col_mins(sorted) do
    [ min_length(sorted, 0), min_length(sorted, 1), min_length(sorted, 2) ]
  end

  def min_length(sorted, col_index) do
    sorted
    |> Enum.chunk_every(num_rows(sorted))
    |> Enum.at(col_index)
    |> Enum.max_by(&(byte_size(&1)))
    |> String.length
  end

  def num_columns(sorted) do
    case length(sorted) do
      1 -> 1
      2 -> 2
      true -> 3
    end
  end

  def num_rows(sorted) do
    sorted
      |> length
      |> Kernel./(3)
      |> Float.ceil
      |> round
  end

  def reconstruct([ h | t ], col_mins) do
    new_row = add_spaces(h, col_mins, 0)
    cond do
      t == [] ->
        ""
      length(t) == 1 ->
        last_row =
          t
          |> Enum.at(0)
          |> add_spaces(col_mins, 0)
        Enum.join(new_row, " ") <> "\n#{Enum.join(last_row, " ")}"
      true ->
        Enum.join(new_row, " ") <> "\n#{reconstruct(t, col_mins)}"
    end
  end

  def stringColumns(words) do
    sorted =
      words
      |> String.split(" ")
      |> Enum.sort
    if length(sorted) == 4 do
      [a, b, c, d] = sorted
      "#{a} #{c} #{d}\n#{b}"
    else
      sorted
      |> arrange
      |> reconstruct(col_mins(sorted))
    end
  end
end

# IO.inspect StringColumns.stringColumns("a b c d e f g h i")
# IO.puts StringColumns.stringColumns("a b c d e f g h i") == "a d g\nb e h\nc f i"
# IO.inspect StringColumns.stringColumns("a b c d e f g h")
# IO.puts StringColumns.stringColumns("a b c d e f g h") == "a d g\nb e h\nc f"
# IO.inspect StringColumns.stringColumns("")
# IO.inspect StringColumns.stringColumns("asdawd")
# IO.inspect StringColumns.stringColumns("a")
# IO.inspect StringColumns.stringColumns("a b")
# IO.inspect StringColumns.stringColumns("a b c")
# IO.inspect StringColumns.stringColumns("a b c d")
# IO.inspect StringColumns.stringColumns("a b c d e")
# IO.inspect StringColumns.stringColumns("a b c d e f")
# IO.inspect StringColumns.stringColumns("a b c d e f g")
# IO.inspect StringColumns.stringColumns("ab b c d e fd g hg")
# IO.puts StringColumns.stringColumns("ab b c d e fd g hg") == "ab b  c  \nd  e  fd\ng  hg"
IO.inspect StringColumns.stringColumns("care elephant pie cat frog pizza")
IO.puts StringColumns.stringColumns("care elephant pie cat frog pizza") == "care elephant pie  \ncat  frog     pizza"
# IO.inspect StringColumns.stringColumns("apples bananas cheese doritos easter fried god humans ippiwaki")
# IO.inspect StringColumns.min_length(["a", "be", "c", "dee", "e", "f", "gasads"], 0)
# IO.puts StringColumns.stringColumns("a b c d") == "a c d\nb"
# IO.inspect StringColumns.stringColumns("a b c")
