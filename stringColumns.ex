require IEx

defmodule StringColumns do
  def stringColumns(words) do
    words
    |> String.split(" ")
    |> Enum.sort
    |> weight(0)
    |> List.flatten
    |> columnize(0)
    |> Enum.join
    |> remove_last_space
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
      [ Enum.take_every(list, 3), weight(next, accum + 1) ]
    else
      []
    end
  end
end

# IO.inspect StringColumns.stringColumns("a b c d e f g h i")
# IO.puts StringColumns.stringColumns("a b c d e f g h i") == "a d g\nb e h\nc f i"
# IO.inspect StringColumns.stringColumns("a b c d e f g h")
# IO.puts StringColumns.stringColumns("a b c d e f g h") == "a d g\nb e h\nc f"
IO.inspect StringColumns.stringColumns("a b c d")
IO.puts StringColumns.stringColumns("a b c d") == "a c d\nb"
