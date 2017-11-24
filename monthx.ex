require IEx

defmodule Month do
  def getMonthName(mo) do
    months = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec"
    ]
    if (mo < 13 && mo > 0) do
      case Enum.fetch(months, mo-1) do
        { :ok, month } ->
          month
        :error ->
          "invalid month"
      end
    else
      "invalid month"
    end
  end
end

IO.puts Month.getMonthName(0) == "invalid month"
IO.puts Month.getMonthName(1) == "Jan"
IO.puts Month.getMonthName(0)
IO.puts Month.getMonthName(1)
IO.puts Month.getMonthName(2)
IO.puts Month.getMonthName(3)
IO.puts Month.getMonthName(4)
IO.puts Month.getMonthName(5)
IO.puts Month.getMonthName(6)
IO.puts Month.getMonthName(7)
IO.puts Month.getMonthName(8)
IO.puts Month.getMonthName(9)
IO.puts Month.getMonthName(10)
IO.puts Month.getMonthName(11)
IO.puts Month.getMonthName(12)
IO.puts Month.getMonthName(13)
IO.puts Month.getMonthName(14)
IO.puts Month.getMonthName(15)
