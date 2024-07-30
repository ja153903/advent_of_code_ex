defmodule Yr2018.Day2Test do
  use ExUnit.Case
  doctest Yr2018.Day2

  test "should solve part 1" do
    assert Yr2018.Day2.solve_part1() == 7808
  end

  test "should solve part 2" do
    assert Yr2018.Day2.solve_part2() == "efmyhuckqldtwjyvisipargno"
  end
end
