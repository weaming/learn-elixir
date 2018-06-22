"""
iex> {:ok, agent} = Agent.start_link(fn -> [1, 2, 3] end)
iex> Agent.update(agent, fn (state) -> state ++ [4, 5] end)
iex> Agent.get(agent, &(&1))

iex> Agent.start_link(fn -> [1, 2, 3] end, name: Numbers)
iex> Agent.get(Numbers, &(&1))
"""
