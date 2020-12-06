defmodule Aoc2020ex.Utils do
  def split_into_chars(string) do
    for <<c::utf8 <- string>>, do: <<c::utf8>>
  end
end
