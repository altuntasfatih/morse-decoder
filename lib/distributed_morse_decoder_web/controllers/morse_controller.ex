defmodule DistributedMorseDecoderWeb.MorseController do
  use DistributedMorseDecoderWeb, :controller


  def index(conn, _params) do
    text(conn, "Morse Decoder")
  end
end
