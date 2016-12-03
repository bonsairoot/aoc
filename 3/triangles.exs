defmodule Triangles do
  import Enum
  '''
  Run map in parallel
  Copied from programming elixir 1.3 (Dave Thomas)
  '''
  def pmap(collection, fun) do
    me = self
    collection
    |> map(fn (elem) ->
      spawn_link fn -> (send me, { self, fun.(elem) }) end
    end)
    |> map(fn (pid) ->
      receive do { ^pid, result } -> result end
    end)
  end

  '''
  Part I
  Simple approach of sorting the values on each line
  and compare the two smallest one to the biggest
  '''
  def countTriangles(input_file) do
    File.read!(input_file)
    |>String.split("\n",trim: true)
    |>pmap(&(String.split(&1)|>process|>validate))
    |>sum
    |>IO.puts
  end

  defp process(x) do
    map(x,&String.to_integer/1)
    |>sort
  end

  defp validate([x,y,z]) when (x+y)>z, do: 1
  defp validate(_), do: 0

  '''
  Part II
  Zip to get the columns and split each column into
  lists of 3. Afterwards proceed like in part I.
  '''
  def countTrianglesVert(input_file) do
    columns =File.read!(input_file)
    |>String.split("\n",trim: true)
    |>pmap(&String.split/1)
    |>List.zip
    |>pmap(&(Tuple.to_list(&1)|>split_every(3)))

    processColumns(columns,0)
    |>IO.puts
  end

  defp processColumns([],sum), do: sum
  defp processColumns([col | rest],sum) do
    columnSum = col
    |>pmap(&(process(&1)|>validate))
    |>sum
    processColumns(rest,sum+columnSum)
  end

  defp split_every(x,y) when length(x)<y, do: x
  defp split_every(x,y) do
    [elem(Enum.split(x,y),0)|split_every(elem(Enum.split(x,y),1),y)]
  end
end
