defmodule Ext.Random do
  @moduledoc """
  `Ext.Random` provides helper functions to produce random values. Note that
  these functions are **not** suitable for cryptographic use.
  """

  @alphanumeric "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"

  @doc """
  Returns a random alphanumeric (a-z, A-Z, 0-9) string of the specified length.
  The characters are chosen with replacement.
  """
  @spec alphanumeric(number()) :: binary()
  def alphanumeric(count) when is_integer(count) do
    count
    |> Ext.Enum.repeat(fn _ -> sample(@alphanumeric) end)
    |> Enum.join()
  end

  @doc """
  Returns a random codepoint from the input string.
  """
  @spec sample(binary()) :: binary()
  def sample(str) when is_binary(str) do
    str
    |> String.codepoints()
    |> Enum.random()
  end
end
