# quote
quote do: 42

quote do: "Hello"

quote do: :world

quote do: 1 + 2

quote do: if value, do: "True", else: "False"


# unquote
denominator = 2
quote do: divide(42, denominator)
quote do: divide(42, unquote(denominator))


# define macro
defmodule OurMacro do
  defmacro unless(expr, do: block) do
    quote do
      if !unquote(expr), do: unquote(block)
    end
  end
end


defmodule Logger do
  defmacro log(msg) do
    if Application.get_env(:logger, :enabled) do
      quote do
        IO.puts("Logged message: #{unquote(msg)}")
      end
    end
  end
end


defmodule Example do
  require Logger

  def test do
    Logger.log("This is a log message")
  end
end


defmodule Example do
  defmacro hygienic do
    quote do: val = -1
  end

  defmacro unhygienic do
    quote do: var!(val) = -1
  end
end

defmodule Example do
  defmacro double_puts(expr) do
    quote bind_quoted: [expr: expr] do
      IO.puts(expr)
      IO.puts(expr)
    end
  end
end

