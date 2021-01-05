defmodule MorseDecoderWeb.Router do
  use MorseDecoderWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/v1/decoder", MorseDecoderWeb do
    pipe_through :api
    get "/", MorseController, :index
    post "/", MorseController, :new
    put "/:id", MorseController, :decode
  end

  scope "/_monitoring", MorseDecoderWeb do
    pipe_through :api
    get "/", MorseController, :index
  end
end
