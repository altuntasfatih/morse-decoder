defmodule MorseDecoderWeb.MorseController do
  use MorseDecoderWeb, :controller
  import MorseDecoder.DynamicSupervisor
  alias MorseDecoder.Server, as: MorseDecoder

  def index(conn, _params) do
    text(conn, "Morse Decoder")
  end

  def new(conn, params) do
    id = :rand.uniform(100_000)

    case create_morse_decoder(id) do
      {:ok, _pid} ->
        conn
        |> put_status(:ok)
        |> json(%{"id" => id})

      {:error, {:already_started, _}} ->
        new(conn, params)

      {:error, error} ->
        conn
        |> put_status(500)
        |> put_view(MorseDecoderWeb.ErrorView)
        |> render("5XX.json", message: error)
    end
  end

  @spec decode(Plug.Conn.t(), any) :: Plug.Conn.t()
  def decode(conn, %{"id" => id, "code" => code}) do
    case MorseDecoder.decode(id, code) do
      {:ok, state} -> conn |> put_status(:ok) |> json(state)
      {:error, error} -> conn |> put_status(404) |> render("5XX.json", message: error)
    end
  end
end
