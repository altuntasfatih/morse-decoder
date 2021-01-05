defmodule MorseDecoder.Server.Test do
  use ExUnit.Case

  setup do
    {:ok, pid} = GenServer.start_link(MorseDecoder.Server, %MorseDecoder{})
    {:ok, decoder: pid}
  end

  test "it_should_create_with_empty_state", %{decoder: pid} do
    assert get(pid) == %MorseDecoder{text: ""}
  end

  test "it_should_decode HEY", %{decoder: pid} do
    :ok = decode(pid, "....")
    :ok = decode(pid, ".")
    :ok = decode(pid, "-.--")

    assert get(pid) == %MorseDecoder{text: "HEY"}
  end

  def get(decoder) do
    GenServer.call(decoder, :get)
  end

  def decode(decoder, code) do
    GenServer.cast(decoder, {:decode, code})
  end
end
