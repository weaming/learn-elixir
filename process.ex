defmodule Example do
  @doc """
  a simple function
  """
  def add(a, b) do
    IO.puts(a + b)
  end

  @doc """
  receive messages
  """
  def listen do
    receive do
      {:ok, "hello"} -> IO.puts("World")
      _ -> IO.puts "WTF"
    end

    listen()
  end

  @doc """
  exit a process
  """
  def explode, do: exit(:kaboom)

  @doc """
  capture exception
  """
  def run do
    Process.flag(:trap_exit, true)
    spawn_link(Example, :explode, [])

    receive do
      {:EXIT, from_pid, reason} -> IO.puts("Exit reason: #{reason}")
    end
  end

  @doc """
  receive exit message except capture exception
  """
  def run2 do
    {pid, ref} = spawn_monitor(Example, :explode, [])

    receive do
      {:DOWN, ref, :process, from_pid, reason} -> IO.puts("Exit reason: #{reason}")
    end
  end
end


"""
iex> spawn(Example, :add, [2, 3])

iex> pid = spawn(Example, :listen, [])
iex> send pid, {:ok, "hello"}
iex> send pid, :ok

iex> spawn(Example, :explode, [])
iex> spawn_link(Example, :explode, [])

iex> Example.run
iex> Example.run2
"""
