Code.require_file("../support/fake_time_zone_database.exs", __DIR__)

defmodule Ext.DateTest do
  use ExUnit.Case, async: true
  use Mimic

  describe "today!/2" do
    test "returns the date today in the given time zone" do
      stub(
        DateTime,
        :now!,
        fn
          "Asia/Singapore", _ -> DateTime.from_naive!(~N[2024-12-28 04:00:00], "Asia/Singapore", Ext.FakeTimeZoneDatabase)
          "America/New_York", _ -> DateTime.from_naive!(~N[2024-12-27 15:00:00], "America/New_York", Ext.FakeTimeZoneDatabase)
        end
      )

      assert Ext.Date.today!("Asia/Singapore") == ~D[2024-12-28]
      assert Ext.Date.today!("America/New_York") == ~D[2024-12-27]
    end

    test "raises with an invalid time zone" do
      assert_raise ArgumentError, fn ->
        Ext.Date.today!("Asia/Non_Existent")
      end
    end
  end
end
