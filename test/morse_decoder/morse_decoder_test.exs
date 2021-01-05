defmodule MorseDecoderTest do
  use ExUnit.Case
  import MorseDecoder

  test "it_should_create_decoder " do
    assert new() |> get() == ""
  end

  test "it_should_parse_HELLO" do
    assert new()
           |> parse("....")
           |> parse(".")
           |> parse(".-..")
           |> parse(".-..")
           |> parse("---")
           |> get() == "HELLO"
  end
end
