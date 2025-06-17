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
  Delete a specific key from the `map`.

  If the `map` has both the atom and string keys, both of them will be deleted.

  ## Examples

      iex> Ext.LenientMap.delete(%{a: 1, b: 2}, :a)
      %{b: 2}

      iex> Ext.LenientMap.delete(%{"a" => 1, "b" => 2}, :a)
      %{"b" => 2}

      iex> Ext.LenientMap.delete(%{"a" => 1, :a => 2, "b" => 3}, :a)
      %{"b" => 3}

      iex> Ext.LenientMap.delete(%{a: 1, b: 2}, :c)
      %{a: 1, b: 2}
  """
  @spec delete(map(), atom()) :: map()
  def delete(map, atom_key) when is_map(map) and is_atom(atom_key) do
    str_key = Atom.to_string(atom_key)
    Map.drop(map, [atom_key, str_key])
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
    dropped_map = delete(map, atom_key)
    {value, dropped_map}
  end

  @doc """
  Returns true if the `map` as the specified key as an atom or a string.

  ## Examples

      iex> Ext.LenientMap.has_key?(%{a: 1, b: 2}, :a)
      true

      iex> Ext.LenientMap.has_key?(%{"a" => 1, "b" => 2}, :a)
      true

      iex> Ext.LenientMap.has_key?(%{"a" => 1, :a => 2, "b" => 3}, :a)
      true

      iex> Ext.LenientMap.has_key?(%{a: 1, b: 2}, :c)
      false
  """
  @spec has_key?(map(), atom()) :: boolean()
  def has_key?(map, atom_key) when is_map(map) and is_atom(atom_key) do
    str_key = Atom.to_string(atom_key)
    Map.has_key?(map, atom_key) || Map.has_key?(map, str_key)
  end

  @doc """
  Updates the value at the specified key with the given function.

  If a value can be found using both the atom and string keys, the value given
  by the atom key is passed to the updater while the string key is deleted from
  the map.

  If the key is not present in `map`, a `KeyError` exception is raised.

  ## Examples

      iex> Ext.LenientMap.update!(%{a: 1, b: 2}, :a, &(&1 * 10))
      %{a: 10, b: 2}

      iex> Ext.LenientMap.update!(%{"a" => 1, "b" => 2}, :a, &(&1 * 10))
      %{"a" => 10, "b" => 2}

      iex> Ext.LenientMap.update!(%{"a" => 1, :a => 2, "b" => 3}, :a, &(&1 * 10))
      %{:a => 20, "b" => 3}

      iex> Ext.LenientMap.update!(%{}, :c, &(&1 * 10))
      ** (KeyError) key :c not found in: %{}
  """
  @spec update!(map(), atom(), (Map.value() -> Map.value())) :: map()
  def update!(map, atom_key, fun) when is_map(map) and is_atom(atom_key) and is_function(fun, 1) do
    str_key = Atom.to_string(atom_key)

    cond do
      Map.has_key?(map, atom_key) ->
        map
        |> Map.update!(atom_key, fun)
        |> Map.delete(str_key)
      Map.has_key?(map, str_key) ->
        Map.update!(map, str_key, fun)
      true ->
        raise KeyError, key: atom_key, term: map
    end
  end

  @doc """
  Puts the given `value` in `map`. An atom key is used if `map` has primarily
  atom keys. Otherwise, a string key is used.

  ## Examples

      iex> Ext.LenientMap.put(%{a: 1, b: 2}, :c, 3)
      %{a: 1, b: 2, c: 3}

      iex> Ext.LenientMap.put(%{"a" => 1, "b" => 2}, :c, 3)
      %{"a" => 1, "b" => 2, "c" => 3}
  """
  @spec put(map(), atom(), Map.value()) :: map()
  def put(map, atom_key, value) when is_map(map) and is_atom(atom_key) do
    if key_type(map) == :atom do
      Map.put(map, atom_key, value)
    else
      Map.put(map, Atom.to_string(atom_key), value)
    end
  end

  defp key_type(map) when is_map(map) do
    keys = Map.keys(map)

    atom_keys_count = Enum.count(keys, &is_atom/1)
    str_keys_count = Enum.count(keys, &is_binary/1)

    if atom_keys_count >= str_keys_count, do: :atom, else: :str
  end
end
