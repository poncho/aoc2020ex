defmodule Aoc2020ex.Day6 do
  alias Aoc2020ex.Input
  alias Aoc2020ex.Utils

  @input "day6.txt"

  defp parse(input) do
    input
    |> String.trim()
    |> String.split("\n\n")
    |> Enum.map(&String.split(&1, "\n"))
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
    |> Enum.map(&count_group_answers/1)
    |> Enum.sum()
  end

  def part2(input) do
    input
    |> parse()
    |> Enum.map(&count_same_answers/1)
    |> Enum.sum()
  end

  defp count_group_answers(group_answers) do
    group_answers
    |> Enum.join()
    |> Utils.split_into_chars()
    |> Enum.uniq()
    |> Enum.map(&String.length/1)
    |> Enum.sum()
  end

  defp count_same_answers(group_answers) do
    persons_in_group = length(group_answers)

    group_answers
    |> Enum.join()
    |> Utils.split_into_chars()
    |> Enum.group_by(fn answer -> answer end)
    |> Enum.filter(fn {_answer, answers} ->
      length(answers) == persons_in_group
    end)
    |> Enum.count()
  end
end
