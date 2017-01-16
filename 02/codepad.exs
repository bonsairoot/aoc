defmodule Codepad do
  def solve(instructions_file) do
    File.read!(instructions_file)
    |>String.split("\n",trim: true)
    |>get_code(5,[])
  end
  defp get_code([],_,code), do: code |> Enum.reverse |>IO.inspect
  defp get_code([instruction | rest],initial,code) do
    position = String.split(instruction,"",trim: true) |> move(initial)
    get_code(rest,position,[position | code])
  end
  defp move([],position), do: position
  defp move([direction | rest], position) do
    row = div(position-1,3)
    column = position-3*row
    case direction do
      "L" -> move(rest,next_number(position,row*3+1,-1))
      "R" -> move(rest,next_number(position,row*3+3,1))
      "U" -> move(rest,next_number(position,column,-3))
      "D" -> move(rest,next_number(position,6+column,3))
    end
  end
  defp next_number(x,y,_) when x==y, do: x
  defp next_number(x,_,delta), do: x+delta
end

defmodule CustomCodepad do
  @layout [
    0,0,"1",0,0,
    0,"2","3","4",0,
    "5","6","7","8","9",
    0,"A","B","C",0,
    0,0,"D",0,0
  ]

  def solve(instructions_file) do
    File.read!(instructions_file)
    |>String.split("\n",trim: true)
    |>get_code({0,2},[])
  end
  defp get_code([],_,code), do: code |> Enum.reverse |> Enum.each(&(IO.puts(get_grid_value(&1))))
  defp get_code([instruction | rest],initial,code) do
    position = String.split(instruction,"",trim: true) |> move(initial)
    get_code(rest,position,[position | code])
  end
  defp move([],position), do: position
  defp move([direction | rest],{x,y}) do
    case direction do
      "L" -> move(rest,next_position({x-1,y},{x,y}))
      "R" -> move(rest,next_position({x+1,y},{x,y}))
      "U" -> move(rest,next_position({x,y-1},{x,y}))
      "D" -> move(rest,next_position({x,y+1},{x,y}))
    end
  end
  defp next_position({x,y},stay) when x<0 or x>4 or y<0 or y>4, do: stay
  defp next_position(next,stay) do
    case get_grid_value(next) do
      0 -> stay
      _ -> next
    end
  end
  defp get_grid_value({x,y}), do: Enum.at(@layout,5*y+x)
end
