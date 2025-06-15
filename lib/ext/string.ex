defmodule Ext.String do
  @moduledoc """
  `Ext.String` provides helper functions related to strings.
  """

  @doc """
  Returns true if and only if the input is `nil` or a zero-length string.

  ## Examples

      iex> Ext.String.is_empty?(nil)
      true

      iex> Ext.String.is_empty?("")
      true

      iex> Ext.String.is_empty?("  ")
      false

      iex> Ext.String.is_empty?("hello")
      false
  """
  @spec is_empty?(binary() | nil) :: boolean()
  def is_empty?(nil) do
    true
  end

  def is_empty?(str) when is_binary(str) do
    String.length(str) == 0
  end

  @doc """
  Returns false if and only if the input is a string with non-zero length.

  ## Examples

      iex> Ext.String.is_not_empty?(nil)
      false

      iex> Ext.String.is_not_empty?("")
      false

      iex> Ext.String.is_not_empty?("  ")
      true

      iex> Ext.String.is_not_empty?("hello")
      true
  """
  @spec is_not_empty?(binary() | nil) :: boolean()
  def is_not_empty?(str) when is_nil(str) or is_binary(str) do
    !is_empty?(str)
  end
end
