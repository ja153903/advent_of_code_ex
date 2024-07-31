defmodule Utils.Io do
  @spec read_file(integer(), integer()) :: binary()
  def read_file(year, day) do
    filepath = "lib/yr#{year}/data/day#{day}.in"

    case File.read(filepath) do
      {:ok, content} -> content
      {:error, :enoent} -> ""
    end
  end

  @spec readlines(integer(), integer()) :: list(String.t())
  def readlines(year, day) do
    read_file(year, day)
    |> String.split("\n", trim: true)
    |> Enum.filter(fn s -> String.length(s) > 0 end)
  end
end
