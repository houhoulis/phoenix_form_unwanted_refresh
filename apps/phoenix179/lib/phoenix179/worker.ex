defmodule Phoenix179.Worker do
  use GenServer, restart: :transient

  require Logger

  ## Public API

  def start_link(_arg) do
    GenServer.start_link(__MODULE__, 0, name: __MODULE__)
  end

  def add_player(pid) do
    GenServer.cast(__MODULE__, {:add_player, pid})
  end

  ## Callbacks

  def init(arg) do
    Process.send_after(self(), :new_value, 5000)

    {:ok, %{arg: arg, players: []}}
  end

  def handle_info(:new_value, state) do
    Process.send_after(self(), :new_value, 5000)

    state = %{state | arg: state.arg + 1}

    Enum.each(
      state.players,
      fn player -> send(player, {:new_worker_value, state.arg}) end
    )

    {:noreply, state}
  end

  def handle_cast({:add_player, pid}, state) do
    {:noreply, %{state | players: [pid | state.players]}}
  end
end
