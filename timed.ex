defmodule Example do
  def timed(fun, args) do
    {time, result} = :timmer.tc(fun, args)
    IO.puts("Time: #{time} us")
    IO.puts("Result: #{result}")
  end
end
