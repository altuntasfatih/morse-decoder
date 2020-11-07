defmodule DistributedMorseDecoderWeb.Router do
  use DistributedMorseDecoderWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", DistributedMorseDecoderWeb do
    pipe_through :api
  end
end
