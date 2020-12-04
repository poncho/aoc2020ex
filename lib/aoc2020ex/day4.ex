defmodule Aoc2020ex.Day4 do
  alias Aoc2020ex.Input

  defp read(input) do
    input
    |> String.trim()
    |> String.split("\n\n")
    |> Enum.map(&String.split(&1, [" ", "\n"]))
  end

  def run1 do
    "day4.txt"
    |> Input.read()
    |> part1()
  end

  def run2 do
    "day4.txt"
    |> Input.read()
    |> part2()
  end

  def part1(input) do
    input
    |> read()
    |> Enum.map(&parse_data/1)
    |> Enum.filter(&has_required_fields?/1)
    |> Enum.count()
  end

  def part2(input) do
    input
    |> read()
    |> Enum.map(&parse_data/1)
    |> Enum.filter(&full_validation?/1)
    |> Enum.count()
  end

  defp parse_data(passport_data) do
    passport_data
    |> Enum.reduce(%{}, fn field, acc ->
      [key, value] = String.split(field, ":", parts: 2)
      Map.put(acc, key, value)
    end)
  end

  defp has_required_fields?(passport) do
    required_keys = ~w(byr iyr eyr hgt hcl ecl pid)

    Enum.all?(required_keys, &Map.has_key?(passport, &1))
  end

  defp full_validation?(passport) do
    required_fields? = has_required_fields?(passport)

    case required_fields? do
      true ->
        do_full_validation(passport)

      _ ->
        false
    end
  end

  defp do_full_validation(passport) do
    with true <- valid_field?(passport, "byr"),
         true <- valid_field?(passport, "iyr"),
         true <- valid_field?(passport, "eyr"),
         true <- valid_field?(passport, "hgt"),
         true <- valid_field?(passport, "hcl"),
         true <- valid_field?(passport, "ecl"),
         true <- valid_field?(passport, "pid") do
      true
    end
  end

  defp valid_field?(%{"byr" => byr}, "byr") do
    valid_number?(byr, 4, 1920, 2002)
  end

  defp valid_field?(%{"iyr" => iyr}, "iyr") do
    valid_number?(iyr, 4, 2010, 2020)
  end

  defp valid_field?(%{"eyr" => eyr}, "eyr") do
    valid_number?(eyr, 4, 2020, 2030)
  end

  defp valid_field?(%{"hgt" => hgt}, "hgt") do
    cond do
      String.ends_with?(hgt, "cm") ->
        {number, _} = Integer.parse(hgt)
        number >= 150 and number <= 193

      String.ends_with?(hgt, "in") ->
        {number, _} = Integer.parse(hgt)
        number >= 59 and number <= 76

      true ->
        false
    end
  end

  defp valid_field?(%{"hcl" => hcl}, "hcl") do
    Regex.match?(~r/^#[0-9a-f]{6}$/, hcl)
  end

  defp valid_field?(%{"ecl" => ecl}, "ecl") do
    ecl in ~w(amb blu brn gry grn hzl oth)
  end

  defp valid_field?(%{"pid" => pid}, "pid") do
    Regex.match?(~r/^[0-9]{9}$/, pid)
  end

  defp valid_field?(_passport, _) do
    false
  end

  defp valid_number?(number, length, min, max) do
    with true <- String.length(number) == length do
      {number, _} = Integer.parse(number)

      number >= min and number <= max
    end
  end
end
