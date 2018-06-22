defmodule Example do
  def double(x) do
    :timer.sleep(2000)
    x * 2
  end
end

"""
iex> task = Task.async(Example, :double, [2000])
iex> Task.await(task)
"""
