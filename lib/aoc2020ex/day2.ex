defmodule Aoc2020ex.Day2 do
  alias Aoc2020ex.Input

  def run do
    "day2.txt"
    |> Input.read()
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&parse_pwd_row/1)
    |> Enum.filter(&valid_pwd?/1)
    |> Enum.count()
  end

  def run2 do
    "day2.txt"
    |> Input.read()
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&parse_pwd_row/1)
    |> Enum.filter(&valid_pwd_2?/1)
    |> Enum.count()
  end

  defp parse_pwd_row(row) do
    regex = ~r/([0-9]+)-([0-9]+) ([a-z]): ([a-z]+)/
    [_, min, max, letter, pwd] = Regex.run(regex, row)

    {min, _} = Integer.parse(min)
    {max, _} = Integer.parse(max)

    {letter, min, max, pwd}
  end

  defp valid_pwd?({letter, min, max, pwd}) do
    characters = split_into_chars(pwd)

    total_letters =
      characters
      |> Enum.filter(&(&1 == letter))
      |> Enum.count()

    total_letters >= min and total_letters <= max
  end

  defp valid_pwd_2?({letter, index_1, index_2, pwd}) do
    characters = split_into_chars(pwd)

    Enum.at(characters, index_1)
    Enum.at(characters, index_2)

    valid1? = Enum.at(characters, index_1 - 1) == letter
    valid2? = Enum.at(characters, index_2 - 1) == letter

    xor(valid1?, valid2?)
  end

  defp split_into_chars(string) do
    for <<c::utf8 <- string>>, do: <<c::utf8>>
  end

  defp xor(b1, b2) do
    (!b1 and b2) or (b1 and !b2)
  end
end
