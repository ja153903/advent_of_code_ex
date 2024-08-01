defmodule Yr2018.Day3Test do
  use ExUnit.Case
  doctest Yr2018.Day3

  test "should solve part 1" do
    assert Yr2018.Day3.solve_part1() == 104_126
  end

  test "should solve part 2" do
    assert Yr2018.Day3.solve_part2() == "695"
  end
end
