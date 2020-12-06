defmodule Aoc2020ex.Day6Test do
  use ExUnit.Case

  alias Aoc2020ex.Day6

  test "Part1: Should count the valid answers" do
    input = ~S"""
    abc

    a
    b
    c

    ab
    ac

    a
    a
    a
    a

    b
    """

    assert Day6.part1(input) == 11
  end

  test "Part 2: Should count answers of all group" do
    input = ~S"""
    abc

    a
    b
    c

    ab
    ac

    a
    a
    a
    a

    b
    """

    assert Day6.part2(input) == 6
  end
end
