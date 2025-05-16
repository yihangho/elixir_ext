defmodule Ext.LenientMap do
  @moduledoc """
  `Ext.LenientMap` provides helper functions related to `Map` by treating
  string and atom keys as equivalent.
  """

  @doc """
  Returns the value for a specific key from the `map`.

  If a value can be found using both the atom and string keys, the value given
  by the atom key is returned.

  ## Examples

      iex> Ext.LenientMap.get(%{a: 1, b: 2}, :a)
      1

      iex> Ext.LenientMap.get(%{"a" => 1, "b" => 2}, :a)
      1

      iex> Ext.LenientMap.get(%{"a" => 1, :a => 2, "b" => 3}, :a)
      2

      iex> Ext.LenientMap.get(%{a: 1, b: 2}, :c)
      nil

      iex> Ext.LenientMap.get(%{a: 1, b: 2}, :c, :not_found)
      :not_found
  """
  @spec get(map(), atom(), Map.value()) :: Map.value()
  def get(map, atom_key, default \\ nil) when is_map(map) and is_atom(atom_key) do
    str_key = Atom.to_string(atom_key)

    cond do
      Map.has_key?(map, atom_key) -> Map.fetch!(map, atom_key)
      Map.has_key?(map, str_key) -> Map.fetch!(map, str_key)
      true -> default
    end
  end

  @doc """
  Returns the value for a specific key and delete it from the `map`.

  If a value can be found using both the atom and string keys, the value given
  by the atom key is returned, but both entries are dropped from the map.

  ## Examples

      iex> Ext.LenientMap.get_and_delete(%{a: 1, b: 2}, :a)
      {1, %{b: 2}}

      iex> Ext.LenientMap.get_and_delete(%{"a" => 1, "b" => 2}, :a)
      {1, %{"b" => 2}}

      iex> Ext.LenientMap.get_and_delete(%{"a" => 1, :a => 2, "b" => 3}, :a)
      {2, %{"b" => 3}}

      iex> Ext.LenientMap.get_and_delete(%{a: 1, b: 2}, :c)
      {nil, %{a: 1, b: 2}}

      iex> Ext.LenientMap.get_and_delete(%{a: 1, b: 2}, :c, :not_found)
      {:not_found, %{a: 1, b: 2}}
  """
  @spec get_and_delete(map(), atom(), Map.value()) :: {Map.value(), map()}
  def get_and_delete(map, atom_key, default \\ nil) when is_map(map) and is_atom(atom_key) do
    value = get(map, atom_key, default)

    str_key = Atom.to_string(atom_key)
    dropped_map = Map.drop(map, [atom_key, str_key])

    {value, dropped_map}
  end
end
