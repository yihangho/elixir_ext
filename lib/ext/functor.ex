defprotocol Ext.Functor do
  @moduledoc """
  `Ext.Functor` is a protocol for data that can be mapped over. Unlike
  `Enum.map`, which always returns a list, `Ext.Functor.map` returns the same
  data structure as the input. For example, mapping over a list returns a
  list while mapping over a map returns a map.
  """

  def map(data, mapper)
end

defimpl Ext.Functor, for: List do
  def map(data, mapper) do
    Enum.map(data, mapper)
  end
end

defimpl Ext.Functor, for: Map do
  def map(data, mapper) do
    for {k, v} <- data, into: %{} do
      {k, mapper.(v)}
    end
  end
end
