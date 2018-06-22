import Supervisor.Spec

# supervisor
children = [
  # Defines the given module as a worker which will be started with the given arguments.
  worker(SimpleQueue, [], [name: SimpleQueue])
]
# start a supervisor with the given children
{:ok, pid} = Supervisor.start_link(children, strategy: :one_for_one)



# supervisor tree
children = [
  # Defines the given module as a supervisor which will be started with the given arguments.
  supervisor(ExampleApp.ConnectionSupervisor, [[name: ExampleApp.ConnectionSupervisor]]),
  worker(SimpleQueue, [[], [name: SimpleQueue]])
]
{:ok, pid} = Supervisor.start_link(children, strategy: :one_for_one)



# Task supervisor, which is using :simple_one_for_one strategy
children = [
  supervisor(Task.Supervisor, [[name: ExampleApp.TaskSupervisor]])
]
# start a supervisor with the given children
{:ok, pid} = Supervisor.start_link(children, strategy: :one_for_one)
# Starts a supervised task as a child of the given supervisor
{:ok, pid} = Task.Supervisor.start_child(ExampleApp.Tasksupervisor, fn -> 1 + 1 end)
