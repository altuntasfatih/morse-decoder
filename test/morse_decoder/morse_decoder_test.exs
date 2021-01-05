defmodule MorseDecoderTest do
  use ExUnit.Case
  import MorseDecoder

  test "create decoder " do
    assert new() |> get() == ""
  end

  test "parse HELLO" do
    assert new()
           |> parse("....")
           |> parse(".")
           |> parse(".-..")
           |> parse(".-..")
           |> parse("---")
           |> get() == "HELLO"
  end
end
