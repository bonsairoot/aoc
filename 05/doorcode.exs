defmodule Doorcode do
  import String

  '''
  VERY slow but it works
  Figure out how to speed it up
  '''

  def decrypt(id) do
    decrypt(0,id,"")
  end

  defp decrypt(index,id,code) do
    hash = :crypto.hash(:md5, id<>to_string(index)) |> Base.encode16()
    cond do
      String.length(code)==8 -> code
      starts_with?(hash,"00000") -> decrypt(index+1,id,code<>at(hash,5))
      true -> decrypt(index+1,id,code)
    end
  end

  def decryptPost(id) do
    decryptPost(0,id,%{},0)
    |>IO.inspect
  end
  defp decryptPost(index,id,code,number) do
    hash = :crypto.hash(:md5, id<>to_string(index)) |> Base.encode16()
    cond do
      number==8 -> code
      starts_with?(hash,"00000") ->
        {newList,inc}=updateMap(code, Integer.parse(at(hash,5)), at(hash,6))
        decryptPost(index+1,id,newList,number+inc)
      true -> decryptPost(index+1,id,code,number)
    end
  end

  defp updateMap(code,{pos,_},value) when pos<8 do
    case Map.has_key?(code,pos) do
      false -> {Map.put(code,pos,value),1}
      true -> {code,0}
    end
  end
  defp updateMap(code,_pos,_value), do: {code,0}
end
