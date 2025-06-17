defmodule Ext.RandomTest do
  use ExUnit.Case, async: true

  describe "alphanumeric" do
    test "returns a random alphanumeric string" do
      value = Ext.Random.alphanumeric(10)
      assert String.match?(value, ~r/^[a-zA-Z0-9]{10}$/)
    end
  end

  describe "sample" do
    test "returns a random codepoint from the string" do
      input = "world"
      value = Ext.Random.sample(input)
      assert String.length(value) == 1
      assert String.contains?(input, value)
    end
  end
end
