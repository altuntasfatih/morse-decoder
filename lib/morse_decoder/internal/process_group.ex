defmodule MorseDecoder.ProcessGroup do
  require Logger

  def start_link(_arg) do
    Logger.info("Start ProcessGroup")
    :pg.start_link(__MODULE__)
  end

  def join_group(group) do
    :ok = :pg.join(__MODULE__, group, self())
  end

  def join_group(group, pid) when is_pid(pid) do
    :ok = :pg.join(__MODULE__, group, self())
  end

  def child_spec(opts) do
    %{
      id: __MODULE__,
      start: {__MODULE__, :start_link, [opts]},
      type: :worker,
      restart: :permanent,
      shutdown: 500
    }
  end
end
