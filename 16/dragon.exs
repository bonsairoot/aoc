defmodule Devrandom do
  def run(input,length) do
    input
    |>curve(length,length(to_charlist(input)))
    |>String.slice(0,length)
    |>checksum
  end

  defp curve(input, length, current_length) when current_length>length,do: input
  defp curve(input,length,current_length) do
    curve = input
    |> String.reverse
    |> String.split("",trim: true)
    |> Enum.map(&flip/1)
    |> Enum.join

    curve(input<>"0"<>curve,length,current_length*2+1)
  end

  defp checksum(input) do
    checkstring = String.split(input,~r/../,include_captures: true, trim: true)
    |> Enum.map(&get_checkbit/1)
    |> Enum.join

    if checkstring|>to_charlist|>length|>rem(2)==1 do
      checkstring
    else
      checksum(checkstring)
    end
  end
  defp flip("1"),do: "0"
  defp flip(_x),do: "1"
  defp get_checkbit(x) when x=="11" or x=="00", do: 1
  defp get_checkbit(_x), do: 0
end
