defmodule Ext.Nil do
  @moduledoc """
  `Ext.Nil` provides helper functions for values that can potentially be `nil`.
  """

  @doc """
  Transforms the given value using the `mapper` function if the value is not
  `nil`. Returns `nil` otherwise.

  ## Examples

      iex> Ext.Nil.map(3, &(&1 + 5))
      8

      iex> Ext.Nil.map(nil, &(&1 + 5))
      nil
  """
  def map(value, mapper) when is_function(mapper, 1) do
    case value do
      nil -> nil
      _ -> mapper.(value)
    end
  end
end
