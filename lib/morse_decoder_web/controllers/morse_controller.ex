defmodule MorseDecoderWeb.MorseController do
  use MorseDecoderWeb, :controller

  def index(conn, _params) do
    self_node = inspect(node())
    nodes = inspect(Node.list())

    conn
    |> put_status(:ok)
    |> json(%{node: self_node, nodes: nodes})
  end
end
