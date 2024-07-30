defmodule Yr2018.Day1Test do
  use ExUnit.Case
  doctest Yr2018.Day1

  test "should solve part 1" do
    assert Yr2018.Day1.solve_part1() == 505
  end

  test "should solve part 2" do
    assert Yr2018.Day1.solve_part2() == 72330
  end
end
