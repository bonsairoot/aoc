defmodule Signals do
  import Enum

  '''
  Part I and II
  For Part II just delete the reverse in process_column
  Zip to get the columns and then get count for a-z on each
  '''
  def decode(input_file) do
    File.read!(input_file)
    |>String.split("\n", trim: true)
    |>map(&(String.split(&1,"", trim: true)))
    |>List.zip
    |>map(&(Tuple.to_list(&1)|>process_column))
    |>map(&(elem(&1,0)|>IO.puts))
  end

  defp process_column(column) do
    ?a..?z
    |>map(&(get_char_count(&1,column)))
    |>List.keysort(1)
    |>Enum.reverse
    |>hd
  end

  defp get_char_count(char,column) do
    letter = <<char>>
    {String.to_atom(letter),Enum.count(column,fn(x) -> x==letter end)}
  end

end
