defmodule Ext.EnumTest do
  use ExUnit.Case

  doctest Ext.Enum

  describe "repeat/2" do
    test "returns a list with that many elements using the mapper function" do
      assert Ext.Enum.repeat(3, &(&1 * 10)) == [0, 10, 20]
    end
  end
end
