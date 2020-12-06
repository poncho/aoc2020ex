defmodule Aoc2020ex.Day5 do
  alias Aoc2020ex.Input
  alias Aoc2020ex.Utils

  @input "day5.txt"

  defp parse(input) do
    input
    |> String.trim()
    |> String.split("\n")
  end

  def run1 do
    @input
    |> Input.read()
    |> part1()
  end

  def run2 do
    @input
    |> Input.read()
    |> part2()
  end

  def part1(input) do
    input
    |> parse()
    |> Enum.map(fn boarding_pass ->
      boarding_pass
      |> find_seat()
      |> calculate_id()
    end)
    |> Enum.max()
  end

  def part2(input) do
    ids =
      input
      |> parse()
      |> Enum.map(fn boarding_pass ->
        boarding_pass
        |> find_seat()
        |> calculate_id()
      end)
      |> Enum.sort()

    find_my_seat(ids)
  end

  def find_my_seat(ids) do
    case ids do
      [id1, id2 | _] when id1 + 2 == id2 ->
        id1 + 1

      _ ->
        ids
        |> tl()
        |> find_my_seat()
    end
  end

  def find_seat(boarding_pass) do
    row = find_row(boarding_pass)
    column = find_column(boarding_pass)

    {row, column}
  end

  def find_row(boarding_pass) do
    boarding_pass
    |> String.slice(0, 7)
    |> Utils.split_into_chars()
    |> binary_reduce(0, 127)
  end

  def find_column(boarding_pass) do
    boarding_pass
    |> String.slice(7, 3)
    |> Utils.split_into_chars()
    |> binary_reduce(0, 7)
  end

  defp binary_reduce(data, min, max) do
    Enum.reduce(data, {min, max}, &do_binary_reduce/2)
  end

  defp do_binary_reduce(letter, {min, max}) when letter in ~w(F L) and max - min <= 2 do
    min
  end

  defp do_binary_reduce(letter, {min, max}) when letter in ~w(F L) do
    new_max = (max - :math.ceil((max - min) / 2)) |> round()
    {min, new_max}
  end

  defp do_binary_reduce(letter, {min, max}) when letter in ~w(B R) and max - min <= 2 do
    max
  end

  defp do_binary_reduce(letter, {min, max}) when letter in ~w(B R) do
    new_min = (min + :math.ceil((max - min) / 2)) |> round()
    {new_min, max}
  end

  defp calculate_id({row, column}) do
    row * 8 + column
  end
end
