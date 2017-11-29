defmodule N do
  def multiples(n, l, h, m \\ 1, c \\ []) do
    x = n * m
    cond do
      l < x && x < h ->
        multiples(n, l, h, m + 1, c ++ [ x ])
      l > x ->
        multiples(n, l, h, m + 1, c)
      h < x ->
        c
    end
  end

  def compare_lists([ h | t ], [ x | y ]) do
    cond do
      x == "*" ->
        compare_lists(t, y)
      h == x ->
        compare_lists(t, y)
      true ->
        false
    end
  end

  def compare_lists([], _) do
    true
  end

  def compare_lists(_, []) do
    true
  end

  def countDivisibleByN(inputString, n) do
    starting_m = round(Float.floor(low(inputString) / n))
    n
    |> multiples(low(inputString), high(inputString), starting_m)
    |> Enum.filter(&(split_compare(&1, inputString)))
    |> length
  end

  def get_first_m(low, n) do
    Float.floor(low / n)
  end

  def split_compare(int, str) do
    list =
      int
      |> Integer.to_string
      |> String.split("")
      |> Enum.filter(&(&1 != ""))
      |> Enum.reverse

    input =
      str
      |> String.split("")
      |> Enum.filter(&(&1 != ""))
      |> Enum.reverse

      compare_lists(list, input)
  end

  def divisible?(h, n) do
    rem(h/n, 1) == 0.0
  end

  def replace_first_char(list) do
    if String.at(list, 0) == "*" do
      list
      |> String.split("")
      |> Enum.filter(&(&1 != ""))
      |> List.replace_at(0, "1")
      |> Enum.join
    else
      list
    end
  end

  def low(list) do
    list
    |> replace_first_char
    |> String.replace("*", "0")
    |> String.to_integer
  end

  def high(list) do
    list
    |> String.replace("*", "9")
    |> String.to_integer
  end
end

IO.inspect N.countDivisibleByN("1*1*1*", 217)
IO.puts N.countDivisibleByN("1*1*1*", 217) == 6
IO.inspect N.countDivisibleByN("***", 17)
IO.puts N.countDivisibleByN("***", 17) == 53
IO.puts N.countDivisibleByN("2**124*7**", 12) == 8333
