defmodule GenstateExampleTest do
  use ExUnit.Case
  doctest GenstateExample

  test "greets the world" do
    assert GenstateExample.hello() == :world
  end
end
