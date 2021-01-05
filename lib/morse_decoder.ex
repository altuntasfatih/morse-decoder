defmodule MorseDecoder do
  @moduledoc """
  Morse Decoder
  """
  defstruct text: ""

  def new(), do: %MorseDecoder{}
  def new(text), do: %MorseDecoder{text: text}

  def parse(%MorseDecoder{text: text}, signal) do
    (text <> parse(signal))
    |> new()
  end

  defp parse(signal) when is_binary(signal) do
    case signal do
      ".-" -> "A"
      "-..." -> "B"
      "-.-." -> "C"
      "-.." -> "D"
      "." -> "E"
      "..-." -> "F"
      "--." -> "G"
      "...." -> "H"
      ".---" -> "J"
      "-.-" -> "K"
      ".-.." -> "L"
      "--" -> "M"
      "-." -> "N"
      "---" -> "O"
      ".--." -> "P"
      "--.-" -> "Q"
      ".-." -> "R"
      "..." -> "S"
      "-" -> "T"
      "..-" -> "U"
      "...-" -> "V"
      ".--" -> "W"
      "-..-" -> "X"
      "-.--" -> "Y"
      "--.." -> "Z"
      ".----" -> "1"
      "..---" -> "2"
      "...--" -> "3"
      "....-" -> "4"
      "....." -> "5"
      "-...." -> "6"
      "--..." -> "7"
      "---.." -> "8"
      "----." -> "9"
      "-----" -> "0"
      _ -> ""
    end
  end

  def get(%MorseDecoder{text: text}), do: text
end
