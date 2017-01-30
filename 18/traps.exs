defmodule Traps do
  # For Part I change 399999 to 39
  def detect do
    first_row = File.read!("aoc18_input.txt")
    |>String.trim_trailing
    |>String.graphemes

    count_savespots(first_row,count(first_row),399999)
    |>IO.puts
  end

  defp count_savespots(_,spots,0), do: spots
  defp count_savespots(previous_row, spots, rows_left) do
    next = ["."|previous_row]
    |>List.insert_at(-1,".")
    |>Enum.chunk(3,1)
    |>gen_row([])

    count_savespots(next, spots + count(next), rows_left-1)
  end

  defp gen_row([],acc), do: Enum.reverse(acc)
  defp gen_row([[l,_m,r]|tail], acc) when l=="^" and r=="." or r=="^" and l==".", do: gen_row(tail,["^"|acc])
  defp gen_row([_head | tail], acc), do: gen_row(tail,["."|acc])

  defp count(row), do: row |> Enum.filter(&(&1==".")) |> Kernel.length
end
