defmodule Aoc2020ex.Day5Test do
  use ExUnit.Case

  alias Aoc2020ex.Day5

  test "Part1: Should count the valid passports" do
    input = ~S"""
    BFFFBBFRRR
    FFFBBBFRRR
    BBFFBBFRLL
    """

    assert Day5.part1(input) == 820
  end

  test "Find seat" do
    bp = "FBFBBFFRLR"
    assert Day5.find_row(bp) == 44
    assert Day5.find_column(bp) == 5
    assert Day5.find_seat(bp) == {44, 5}
  end
end
