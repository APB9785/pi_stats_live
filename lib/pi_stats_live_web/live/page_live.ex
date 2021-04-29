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
      assign(socket, temp_chart_data: %{
        labels: ["", ""],
        values: [socket.assigns.cels, socket.assigns.cels]
      })

    mem_value = memory_percent(socket)
    socket =
      assign(socket, mem_chart_data: %{
        labels: ["", ""],
        values: [mem_value, mem_value]
      })

    socket =
      assign(socket, cpu_chart_data: %{
        labels: ["", ""],
        values: [socket.assigns.cpu_usage, socket.assigns.cpu_usage]
      })

    {:ok, socket}
  end

  def handle_info(:tick, socket) do
    socket = assign_all(socket)
    temp_point = %{
      label: "",
      value: socket.assigns.cels
    }
    mem_point = %{
      label: "",
      value: memory_percent(socket)
    }
    cpu_point = %{
      label: "",
      value: socket.assigns.cpu_usage
    }

    socket = push_event(socket, "new-temp-point", temp_point)
    socket = push_event(socket, "new-mem-point", mem_point)
    socket = push_event(socket, "new-cpu-point", cpu_point)

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

  defp memory_percent(socket) do
    (socket.assigns.used_memory / socket.assigns.total_memory) * 100
  end
end
