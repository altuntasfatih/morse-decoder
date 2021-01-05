defmodule MorseDecoder.Server.Test do
  use ExUnit.Case

  setup do
    {:ok, pid} = GenServer.start_link(MorseDecoder.Server, %MorseDecoder{})
    {:ok, decoder: pid}
  end

  test "initial state is empty", %{decoder: pid} do
    assert get(pid) == %MorseDecoder{text: ""}
  end

  test "decode E", %{decoder: pid} do
    assert decode(pid, ".") == %MorseDecoder{text: "E"}
  end

  test "decode HEY", %{decoder: pid} do
    decode(pid, "....")
    decode(pid, ".")
    decode(pid, "-.--")

    assert get(pid) == %MorseDecoder{text: "HEY"}
  end

  def get(decoder) do
    GenServer.call(decoder, :get)
  end

  def decode(decoder, code) do
    GenServer.call(decoder, {:decode, code})
  end
end
