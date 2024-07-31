defmodule Yr2018.Day1 do
  @spec get_frequencies() :: list(integer())
  def get_frequencies() do
    content = Utils.Io.read_file(2018, 1)

    if content == "" do
      raise "Something went wrong with reading the file"
    end

    Utils.Io.readlines(content)
    |> Enum.map(fn x ->
      case Integer.parse(x) do
        {value, _rem} -> value
        :error -> 0
      end
    end)
  end

  @spec solve_part1() :: integer()
  def solve_part1() do
    get_frequencies()
    |> Enum.reduce(fn x, acc -> x + acc end)
  end

  @spec solve_part2() :: integer()
  def solve_part2 do
    frequencies = get_frequencies()
    reduce_loop(frequencies, %{0 => 1}, 0)
  end

  @spec reduce_loop(list(integer()), %{integer() => integer()}, integer()) :: integer()
  def reduce_loop(frequencies, init_freqs, init_sum) do
    {updated_freqs, resulting_sum, should_break_loop} =
      frequencies
      |> Enum.reduce({init_freqs, init_sum, false}, fn x, acc ->
        {freqs, sum, has_reached_twice} = acc

        if has_reached_twice do
          acc
        else
          if Map.has_key?(freqs, sum + x) do
            case Map.fetch(freqs, sum + x) do
              {:ok, count} ->
                {Map.put(freqs, sum + x, count + 1), sum + x, true}

              :error ->
                raise "Something went wrong"
            end
          else
            {Map.put(freqs, sum + x, 1), sum + x, false}
          end
        end
      end)

    if should_break_loop do
      resulting_sum
    else
      reduce_loop(frequencies, updated_freqs, resulting_sum)
    end
  end
end
