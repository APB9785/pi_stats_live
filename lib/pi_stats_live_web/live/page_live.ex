defmodule PiStatsLiveWeb.PageLive do
  use PiStatsLiveWeb, :live_view

  alias PiStatsLive.Disk
  alias PiStatsLive.SysInfo
  alias PiStatsLive.SysProcs
  alias PiStatsLive.Temp

  def mount(_params, _session, socket) do
    if connected?(socket) do
      :timer.send_interval(2500, self(), :tick)
    end

    socket =
      socket
      |> assign_all
      |> assign(local_ip: SysInfo.get_local_ip())
      |> assign(hostname: SysInfo.get_hostname())

    socket =
      assign(socket, chart_data: %{
        labels: ["", ""],
        values: [socket.assigns.cels, socket.assigns.cels]
      })

    {:ok, socket}
  end

  def handle_info(:tick, socket) do
    socket = assign_all(socket)
    point = %{
      label: "",
      value: socket.assigns.cels
    }

    socket = push_event(socket, "new-point", point)

    {:noreply, socket}
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
