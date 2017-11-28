require IEx

defmodule StringColumns do
  def stringColumns(words) do
    words
    |> String.split(" ")
    |> Enum.sort
    |> weight(0)
    |> check_empty
    |> List.flatten
    |> columnize(0)
    |> Enum.join
    |> remove_last_space
  end

  def check_empty([h | t]) do
    if length(h) < 3 do
      { sec_thir_rows, rest } = Enum.split(t, 2)
      third_row = List.last(sec_thir_rows)
      { word , new_third_row } = Enum.split(third_row, 1)
      first_row =
        h
        |> Enum.concat(word)
        |> Enum.sort

      sec_thir_rows =
        if length(sec_thir_rows) > 1 do
          if new_third_row == [] do
            { output, _unused } = Enum.split(sec_thir_rows, 1)
            output
          else
            List.replace_at(sec_thir_rows, -1, new_third_row)
          end
        else
          [ new_third_row ]
        end
      new_lists = List.insert_at(sec_thir_rows, 0, first_row)
      if rest == [] do
        check_empty(new_lists)
      else
        check_empty(Enum.concat(new_lists, rest))
      end
    else
      [ h | t ]
    end
  end

  def check_empty(nil) do
    nil
  end

  def columnize([ h | t ], accum) do
    if rem(accum, 3) == 2 do
      [ "#{h}\n" | columnize(t, accum+1) ]
    else
      [ "#{h} " | columnize(t, accum+1) ]
    end
  end

  def columnize([], _accum) do; []; end;

  def remove_last_space(string) do
    { output, _space } = String.split_at(string, -1)
    output
  end

  def weight(list, accum) do
    if (accum < 3) do
      { _, next } = Enum.split(list, 1)
      [ Enum.take_every(list, 3) | weight(next, accum + 1) ]
    else
      []
    end
  end
end

# IO.inspect StringColumns.stringColumns("a b c d e f g h i")
# IO.puts StringColumns.stringColumns("a b c d e f g h i") == "a d g\nb e h\nc f i"
# IO.inspect StringColumns.stringColumns("a b c d e f g h")
# IO.puts StringColumns.stringColumns("a b c d e f g h") == "a d g\nb e h\nc f"
# IO.inspect StringColumns.check_empty(StringColumns.weight(["a", "b", "c", "d"], 0))
# IO.inspect StringColumns.stringColumns("a b c d")
# IO.puts StringColumns.stringColumns("a b c d") == "a c d\nb"
IO.inspect StringColumns.stringColumns("a b c")
