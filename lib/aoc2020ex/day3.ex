defmodule Aoc2020ex.Day3 do
  alias Aoc2020ex.Input

  def input do
    "day3.txt"
    |> Input.read()
    |> String.trim()
    |> String.split("\n")
  end

  def run do
    input()
    |> slide()
    |> Enum.count(fn point -> point == "#" end)
  end

  def run2 do
    map = input()

    slopes = [
      {1, 1},
      {3, 1},
      {5, 1},
      {7, 1},
      {1, 2}
    ]

    slopes
    |> Enum.map(fn increments ->
      slide(map, increments)
    end)
    |> Enum.reduce(1, fn tree_amount, acc -> acc * tree_amount end)
  end

  defp slide(map) do
    map
    |> Enum.with_index()
    |> Enum.drop(1)
    |> Enum.map(fn {map_row, index} ->
      next_point = rem(index * 3, String.length(map_row))
      String.at(map_row, next_point)
    end)
  end

  defp slide(map, increments) do
    do_slide(map, increments, {0, 0})
  end

  defp do_slide(map, {inc_right, inc_down} = increments, {point_right, point_down}, path \\ []) do
    next_point_down = point_down + inc_down

    case Enum.at(map, next_point_down) do
      nil ->
        Enum.count(path, fn point -> point == "#" end)

      map_row ->
        next_point_right = rem(point_right + inc_right, String.length(map_row))

        next_point = {next_point_right, next_point_down}

        updated_path = [String.at(map_row, next_point_right) | path]
        do_slide(map, increments, next_point, updated_path)
    end
  end
end
