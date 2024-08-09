defmodule StackTest do
  use ExUnit.Case
  doctest Stack

  describe "start_link/1" do
    test "starts a stack with an empty list" do
      {:ok, pid} = Stack.start_link()
      assert :sys.get_state(pid) == []
    end

    test "starts a stack with a list" do
      {:ok, pid} = Stack.start_link([1, 2, 3])
      assert :sys.get_state(pid) == [1, 2, 3]
    end
  end

  describe "pop/1" do
    test "pops the top element from the stack" do
      {:ok, pid} = Stack.start_link([1, 2, 3])
      assert Stack.pop(pid) == 1
      assert :sys.get_state(pid) == [2, 3]
    end

    test "pops more than one element from the stack" do
      {:ok, pid} = Stack.start_link([1, 2, 3])
      assert Stack.pop(pid) == 1
      assert Stack.pop(pid) == 2
      assert :sys.get_state(pid) == [3]
    end

    test "doesn't pop if the stack is empty" do
      {:ok, pid} = Stack.start_link()
      assert Stack.pop(pid) == nil
      assert :sys.get_state(pid) == []
    end
  end

  describe "push/2" do
    test "pushes an element to the stack" do
      {:ok, pid} = Stack.start_link([1, 2, 3])
      assert Stack.push(pid, 4) == :ok
      assert :sys.get_state(pid) == [4, 1, 2, 3]
    end

    test "pushes an element to an empty stack" do
      {:ok, pid} = Stack.start_link()
      assert Stack.push(pid, 1) == :ok
      assert :sys.get_state(pid) == [1]
    end
  end
end
