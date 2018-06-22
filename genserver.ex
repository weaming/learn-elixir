defmodule SimpleQueue do
  use GenServer

  @doc """
  GenServer.init/1 callback
  """
  def init(state), do: {:ok, state}

  @doc """
  GenServer.handle_call/3 callback
  dequeue
  """
  def handle_call(:dequeue, _from, [value | state]) do
    # {:reply, return value, new state}
    {:reply, value, state}
  end

  @doc """
  dequeue
  """
  def handle_call(:dequeue, _from, []), do: {:reply, nil, []}

  @doc """
  query current state
  """
  def handle_call(:queue, _from, state), do: {:reply, state, state}

  def handle_cast({:enqueue, value}, state) do
    {:noreply, state ++ [value]}
  end

  ### Client API
  @doc """
  start our queue and link it
  """
  def start_link(state \\ []) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  def queue, do: GenServer.call(__MODULE__, :queue)
  def enqueue(value), do: GenServer.cast(__MODULE__, {:enqueue, value})
  def dequeue, do: GenServer.call(__MODULE__, :dequeue)
end
