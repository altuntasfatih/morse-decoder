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
  def handle_cast({:decode, code}, state) do
    new_state = MorseDecoder.parse(state, code)
    {:noreply, new_state}
  end

  def decode(id, code) when is_binary(code) do
    fn pid -> GenServer.cast(pid, {:decode, code}) end
    |> call(id)
  end

  def get(id) do
    fn pid -> GenServer.call(pid, :get) end
    |> call(id)
  end

  defp call(operation, id) when is_binary(id), do: call(operation, String.to_integer(id))

  defp call(operation, id) when is_integer(id) do
    case :global.whereis_name({id, __MODULE__}) do
      :undefined ->
        {:error, "Decoder not found"}

      pid ->
        operation.(pid)
    end
  end
end
