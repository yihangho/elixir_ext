defmodule Ext.FunctorTest do
  use ExUnit.Case, async: true

  test "with a list" do
    input = [1, 2, 3]
    mapper = fn x -> 2 ** x end

    assert Ext.Functor.map(input, mapper) == [2, 4, 8]
  end

  test "with a map" do
    input = %{a: 1, b: 2, c: 3}
    mapper = fn x -> 2 ** x end

    assert Ext.Functor.map(input, mapper) == %{a: 2, b: 4, c: 8}
  end
end
