defmodule Yr2018.Day3 do
  @spec get_lines() :: list()
  def get_lines() do
    Utils.Io.readlines(2018, 3)
  end

  @spec parse_line(String.t()) :: tuple()
  def parse_line(line) do
    # we want to use regex to get named captures for each line
    m =
      Regex.named_captures(
        ~r/#(?<id>\d+) @ (?<p0>\d+),(?<p1>\d+): (?<width>\d+)x(?<height>\d+)/,
        line
      )

    p0 =
      case Integer.parse(m["p0"]) do
        {value, _} -> value
        :error -> raise "Could not parse p0"
      end

    p1 =
      case Integer.parse(m["p1"]) do
        {value, _} -> value
        :error -> raise "Could not parse p1"
      end

    width =
      case Integer.parse(m["width"]) do
        {value, _} -> value
        :error -> raise "Could not parse width"
      end

    height =
      case Integer.parse(m["height"]) do
        {value, _} -> value
        :error -> raise "Could not parse height"
      end

    {m["id"], p0, p1, width, height}
  end

  @spec update_overlaps(map(), tuple()) :: map()
  def update_overlaps(counter, metadata) do
    {_id, p0, p1, width, height} = metadata

    all_pairs = for x <- p0..(p0 + width - 1), y <- p1..(p1 + height - 1), do: {x, y}

    Enum.reduce(all_pairs, counter, fn pair, acc ->
      {a, b} = pair
      key = "#{a},#{b}"
      Map.update(acc, key, 1, fn cur -> cur + 1 end)
    end)
  end

  @spec solve_part1() :: integer()
  def solve_part1() do
    get_lines()
    |> Enum.map(fn line -> parse_line(line) end)
    |> Enum.reduce(%{}, fn metadata, acc -> update_overlaps(acc, metadata) end)
    |> Enum.filter(fn {_k, v} -> v >= 2 end)
    |> length
  end

  @spec solve_part2() :: String.t()
  def solve_part2() do
    metadata =
      get_lines()
      |> Enum.map(fn line -> parse_line(line) end)

    overlaps =
      metadata
      |> Enum.reduce(%{}, fn metadata, acc -> update_overlaps(acc, metadata) end)

    tuple_with_no_overlap(metadata, overlaps) |> elem(0)
  end

  @spec tuple_with_no_overlap(list(tuple()), map()) :: tuple()
  def tuple_with_no_overlap(metadata, overlaps) do
    Enum.find(metadata, fn tup ->
      {_id, p0, p1, width, height} = tup
      all_pairs = for x <- p0..(p0 + width - 1), y <- p1..(p1 + height - 1), do: {x, y}

      Enum.all?(all_pairs, fn pair ->
        {a, b} = pair
        key = "#{a},#{b}"
        Map.get(overlaps, key) == 1
      end)
    end)
  end
end
