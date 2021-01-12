defmodule PiStatsLiveWeb.StatsLive do
  use PiStatsLiveWeb, :live_view

  alias PiStatsLive.Temp
  alias PiStatsLive.SysProcs
  alias PiStatsLive.Disk

  def mount(_params, _session, socket) do
    if connected?(socket) do
      :timer.send_interval(5000, self(), :tick)
    end
      
    {:ok, assign_all(socket)}
  end

  def handle_info(:tick, socket) do
    {:noreply, assign_all(socket)}
  end

  def assign_all(socket) do
    c_temp = Temp.get_current()
    f_temp = Float.round(c_temp * 1.8 + 32, 1)
    proc_map = SysProcs.get_current()
    disk_map = Disk.get_current()

    socket
    |> assign(cels: Float.to_string(c_temp))
    |> assign(fahr: Float.to_string(f_temp)) 
    |> assign(proc_map)
    |> assign(disk_map)
  end

end
