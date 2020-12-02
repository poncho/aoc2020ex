defmodule Aoc2020ex.Input do
  def read(name) do
    path = Path.join("input/", name)
    File.read!(path)
  end
end
