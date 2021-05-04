defmodule PiStatsLiveWeb.CpuChartComponent do
  @moduledoc """
  CPU usage chart
  """

  use PiStatsLiveWeb, :live_component

  def render(assigns) do
    ~L"""
    <div class="w-2/3 justify-self-center md:w-1/4">
      <div phx-update="ignore">
        <canvas id="cpu-chart-canvas"
                phx-hook="CpuChart"
                data-chart-data="<%= Jason.encode!(@cpu_chart_data) %>">
        </canvas>
      </div>
      <p align="center" class="text-base md:text-lg">
        <strong>CPU Usage:</strong>
        <%= @cpu_usage %> %
      </p>
    </div>
    """
  end
end
