defmodule DistributedMorseDecoderWeb.Router do
  use DistributedMorseDecoderWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/v1/decoder", DistributedMorseDecoderWeb do
    pipe_through :api
    get "/", MorseController, :index
  end
end
