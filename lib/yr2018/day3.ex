defmodule Yr2018.Day3 do
  @spec get_lines() :: list()
  def get_lines() do
    Utils.Io.read_file(2018, 3)
    |> String.split("\n", trim: true)
    |> Enum.filter(fn s -> String.length(s) > 0 end)
  end

  @spec solve_part1() :: integer()
  def solve_part1() do
    0
  end

  @spec solve_part2() :: integer()
  def solve_part2() do
    0
  end
end
