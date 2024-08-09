defmodule Stack do
  @moduledoc """
  Simple Stack implementation using GenServer.
  """

  use GenServer

  @doc """
  Starts a stack with a list. Default: empty list.
  """
  @spec start_link([any()]) :: {:ok, pid()}
  def start_link(stack \\ []) do
    GenServer.start_link(__MODULE__, stack)
  end

  @doc """
  Pops an element from the stack.

  Returns the top element of the stack and updates the stack.

  Examples:

      iex> {:ok, pid} = Stack.start_link([1, 2, 3])
      iex> Stack.pop(pid)
      1
      iex> :sys.get_state(pid)
      [2, 3]
  """
  @spec pop(pid()) :: any()
  def pop(pid) do
    GenServer.call(pid, :pop)
  end

  @doc """
  Pushes an element to the stack.

  Examples:

      iex> {:ok, pid} = Stack.start_link([1, 2, 3])
      iex> Stack.push(pid, 4)
      :ok
      iex> :sys.get_state(pid)
      [4, 1, 2, 3]
  """
  @spec push(pid(), any()) :: :ok
  def push(pid, element) do
    GenServer.cast(pid, {:push, element})
  end

  @impl true
  def init(init_arg) do
    {:ok, init_arg}
  end

  @impl true
  def handle_call(:pop, _from, state) do
    case state do
      [head | tail] ->
        {:reply, head, tail}

      [] ->
        {:reply, nil, state}
    end
  end

  @impl true
  def handle_cast({:push, element}, state) do
    {:noreply, [element | state]}
  end
end
