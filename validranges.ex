defmodule N do
def sumAllRanges(array) do
  array
  |> Enum.sort
  |> valid_ranges
  |> sum_ranges
  |> reduce
end

def reduce(sum) do
  mod =
    10
    |> :math.pow(9)
    |> Kernel.+(7)
    |> round

  rem(sum, mod)
end

def sum_ranges([ h | t ]) do
  [ l, h ] = h
  reduce(Enum.sum(l..h)) + sum_ranges(t)
end

def sum_ranges([]) do
  0
end

def valid_ranges([ h | t ]) do
  t
  |> Enum.map(&([reduce(h), reduce(&1)]))
  |> Kernel.++(valid_ranges(t))
end

def valid_ranges([]) do
  []
end
end

IO.inspect N.valid_ranges([1,2,5])
IO.puts N.valid_ranges([1,2,5]) == [[1, 2], [1, 5], [2, 5]]
IO.puts N.sumAllRanges([1,2,5]) == 32
IO.inspect N.sumAllRanges([792196, 725628, 979069, 335956, 616477, 2774, 966018, 336439, 486360, 114639, 507179, 689114, 570402, 441924, 803003, 683835, 586933, 672728, 619719, 46972, 470008, 854897, 62028, 277508, 791505, 535787, 57508, 699809, 487503, 118350, 658376, 22612, 536617, 290977, 284963, 1280, 368327, 561437, 629293, 356477, 138793, 17519, 426620, 2093, 36965, 224934, 155553, 138741, 907036, 761972, 695979, 166902, 157497, 40758, 810497, 916646, 678550, 389541, 91845, 776104, 597440, 902724, 907320, 491435, 34366, 323318, 959509, 281551, 826957, 385225, 78375, 525407, 933613, 562819, 166359, 789581, 269483, 362873, 9104, 228585, 47637, 145033, 83038, 147611, 115449, 886289, 586268, 755477, 207853, 621100, 869692, 157022, 694335, 364326, 305034, 26382, 801382, 785351, 268523, 294007])
IO.puts N.valid_ranges([1,2,5]) == [[1, 2], [1, 5], [2, 5]]

big_num = round(:math.pow(10, 6))
big_size = round(:math.pow(10, 5))
big_list = List.duplicate(big_num, round(big_size/44))

IO.inspect N.sumAllRanges(big_list)
