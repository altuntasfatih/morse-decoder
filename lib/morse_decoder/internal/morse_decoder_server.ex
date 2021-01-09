defmodule MorseDecoder.Server do
  use GenServer
  require Logger
  import MorseDecoder.ProcessGroup

  @timeout 5_000
  def start_link({initial_state, id}) do
    {:ok, pid} =
      GenServer.start_link(__MODULE__, initial_state, name: {:global, {id, __MODULE__}})

    :ok = join_group({id, __MODULE__}, pid)
    {:ok, pid}
  end

  @impl true
  def init(state = %MorseDecoder{}) do
    Logger.info("MorseDecoder has been started")

    {:ok, state, @timeout}
  end

  @impl true
  def handle_call(:get, _from, state) do
    {:reply, state, state, @timeout}
  end

  @impl true
  def handle_cast({:decode, code}, state) do
    new_state = MorseDecoder.parse(state, code)
    {:noreply, new_state, @timeout}
  end

  @impl true
  def handle_info(:timeout, _) do
    Logger.info("Morse decoder shutting down ")
    {:stop, :normal, []}
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

  def child_spec(opts) do
    %{
      id: __MODULE__,
      start: {__MODULE__, :start_link, [opts]},
      type: :worker,
      restart: :transient,
      shutdown: 500
    }
  end
end
