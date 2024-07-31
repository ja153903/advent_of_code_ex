defmodule Utils.Io do
  @spec read_file(integer(), integer()) :: binary()
  def read_file(year, day) do
    filepath = "lib/yr#{year}/data/day#{day}.in"

    case File.read(filepath) do
      {:ok, content} -> content
      {:error, :enoent} -> ""
    end
  end

  @spec readlines(String.t()) :: list(String.t())
  def readlines(content) do
    content
    |> String.split("\n", trim: true)
    |> Enum.filter(fn s -> String.length(s) > 0 end)
  end
end
