defmodule Ext.Enum do
  @moduledoc """
  `Ext.Enum` provides helper functions related to `Enum`.
  """

  @doc """
  Returns a list by invoking the mapper function the given number of times.

  ## Examples

      iex> Ext.Enum.repeat(3, &(&1 + 5))
      [5, 6, 7]
  """
  @spec repeat(number(), (number() -> element)) :: [element] when element: var
  def repeat(count, mapper) when is_integer(count) and is_function(mapper, 1) do
    Enum.map(0..count-1, mapper)
  end
end
