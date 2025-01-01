defmodule Ext.Date do
  @moduledoc """
  `Ext.Date` provides helper functions related to `Date`.
  """

  @doc """
  Returns the date today in the specified time zone. May require a time zone database. See [here](https://hexdocs.pm/elixir/DateTime.html#module-time-zone-database) for details.
  """
  @spec today!(Calendar.time_zone(), Calendar.time_zone_database()) :: Date.t()
  def today!(time_zone, time_zone_database \\ Calendar.get_time_zone_database()) do
    DateTime.now!(time_zone, time_zone_database) |> DateTime.to_date()
  end
end
