defmodule Yr2018.Day2 do
  @spec get_lines() :: list(String.t())
  def get_lines() do
    content = Utils.Io.read_file(2018, 2)

    if content == "" do
      raise "Something went wrong with reading the file"
    end

    Utils.Io.readlines(content)
  end

  @spec get_frequencies(String.t()) :: map()
  def get_frequencies(line) do
    line |> String.graphemes() |> Enum.frequencies()
  end

  @spec has_2count?(map()) :: boolean()
  def has_2count?(frequencies) do
    Enum.reduce(frequencies, false, fn {_k, v}, acc ->
      acc || v == 2
    end)
  end

  @spec has_3count?(map()) :: boolean()
  def has_3count?(frequencies) do
    Enum.reduce(frequencies, false, fn {_k, v}, acc ->
      acc || v == 3
    end)
  end

  @spec solve_part1() :: integer()
  def solve_part1() do
    m =
      get_lines()
      |> Enum.reduce(%{two: 0, three: 0}, fn x, acc ->
        freqs = get_frequencies(x)

        inc = fn cur -> cur + 1 end

        case {has_2count?(freqs), has_3count?(freqs)} do
          {true, true} ->
            acc
            |> Map.update(:two, 1, inc)
            |> Map.update(:three, 1, inc)

          {true, false} ->
            acc
            |> Map.update(:two, 1, inc)

          {false, true} ->
            acc
            |> Map.update(:three, 1, inc)

          {false, false} ->
            acc
        end
      end)

    m[:two] * m[:three]
  end

  @spec solve_part2() :: String.t()
  def solve_part2() do
    lines = get_lines()

    # go through all combinations
    combinations = for x <- lines, y <- lines, x != y, do: [x, y]

    combinations
    |> Enum.find(fn x ->
      num_diff_pairs =
        List.zip(x |> Enum.map(&String.graphemes/1))
        |> Enum.filter(fn zt ->
          {a, b} = zt
          a != b
        end)
        |> length

      num_diff_pairs == 1
    end)
    |> get_remaining_chars()
  end

  @spec get_remaining_chars(list(String.t())) :: String.t()
  def get_remaining_chars(pair) do
    List.zip(pair |> Enum.map(&String.graphemes/1))
    |> Enum.filter(fn zt ->
      {a, b} = zt
      a == b
    end)
    |> Enum.map(fn zt ->
      {a, _} = zt
      a
    end)
    |> Enum.join()
  end
end
