defmodule Aoc2020ex.Day1 do
  alias Aoc2020ex.Input

  def run do
    "day1.txt"
    |> Input.read()
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(fn value ->
      {value, _} = Integer.parse(value)
      value
    end)
    |> find_match()
  end

  def run2 do
    "day1.txt"
    |> Input.read()
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(fn value ->
      {value, _} = Integer.parse(value)
      value
    end)
    |> find_triple_match()
  end

  def find_match([head | tail]) do
    tail
    |> Enum.find(fn value -> head + value == 2020 end)
    |> case do
      nil ->
        find_match(tail)

      value ->
        IO.puts("Values: #{head}, #{value}")
        answer = head * value
        IO.puts("Answer: #{answer}")
        answer
    end
  end

  def find_triple_match([v1 | tail]) do
    pp =
      tail
      |> Enum.map(fn value ->
        case v1 + value < 2020 do
          true ->
            {v1, value}

          _ ->
            nil
        end
      end)
      |> Enum.reject(&is_nil/1)

    pp
    |> Enum.find_value(fn {v1, v2} ->
      case Enum.find(tail, fn value -> v1 + v2 + value == 2020 end) do
        nil ->
          nil

        match ->
          {v1, v2, match}
      end
    end)
    |> case do
      nil ->
        rt = Enum.reverse(tail)

        [v1 | rt]
        |> Enum.reverse()
        |> find_triple_match()

      {v1, v2, v3} ->
        IO.puts("Values: #{v1}, #{v2}, #{v3}")
        answer = v1 * v2 * v3
        IO.puts("Answer: #{answer}")
        answer
    end
  end
end

# x + y + z = 2020
