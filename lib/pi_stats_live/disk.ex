defmodule PiStatsLive.Disk do
  def get_current do
    System.cmd("df", [])
    |> IO.inspect
  end
end

PiStatsLive.Disk.get_current()
