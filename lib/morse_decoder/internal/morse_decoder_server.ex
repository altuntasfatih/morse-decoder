defmodule MorseDecoder.Server do
  use GenServer
  require Logger

  def start_link({initial_state, id}) do
    GenServer.start_link(__MODULE__, initial_state, name: {:global, {id, __MODULE__}})
  end

  @impl true
  def init(state = %MorseDecoder{}) do
    Logger.info("MorseDecoder has been started")
    {:ok, state}
  end

  @impl true
  def handle_call(:get, _from, state) do
    {:reply, state, state}
  end

  @impl true
  def handle_call({:decode, code}, _from, state) do
    new_state = MorseDecoder.parse(state, code)
    {:reply, new_state, new_state}
  end

  def decode(id, code) when is_binary(code) do
    case :global.whereis_name({id, __MODULE__}) do
      pid when is_pid(pid) ->
        GenServer.call(pid, {:put, code})

      :undefined ->
        {:error, "Decoder not found"}
    end
  end
end
