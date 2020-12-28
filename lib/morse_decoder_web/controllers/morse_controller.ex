defmodule MorseDecoderWeb.MorseController do
  use MorseDecoderWeb, :controller

  def index(conn, _params) do
    text(conn,"Morse Decoder")
  end
end
