defmodule Ext.FakeTimeZoneDatabase do
  @behaviour Calendar.TimeZoneDatabase

  @time_zones %{
    "Etc/UTC" => 0,
    "Asia/Singapore" => 8,
    "America/New_York" => -5
  }

  @impl true
  def time_zone_period_from_utc_iso_days(_iso_days, time_zone) do
    time_zone_period(time_zone)
  end

  @impl true
  def time_zone_periods_from_wall_datetime(_naive_datetime, time_zone) do
    time_zone_period(time_zone)
  end

  defp time_zone_period(time_zone) when is_binary(time_zone) do
    case Map.fetch(@time_zones, time_zone) do
      {:ok, offset} ->
        {:ok, %{
          std_offset: 0,
          utc_offset: offset * 3600,
          zone_abbr: time_zone |> String.split("/") |> List.last(),
          wall_period: nil
        }}
      :error ->
        {:error, :time_zone_not_found}
    end
  end
end
