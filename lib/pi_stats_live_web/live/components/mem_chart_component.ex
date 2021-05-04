defmodule PiStatsLiveWeb.MemChartComponent do
  @moduledoc """
  Memory chart
  """

  use PiStatsLiveWeb, :live_component

  def render(assigns) do
    ~L"""
    <div class="w-2/3 justify-self-center my-8 md:m-0 md:w-1/4">
      <div phx-update="ignore">
        <canvas id="mem-chart-canvas"
                phx-hook="MemChart"
                data-chart-data="<%= Jason.encode!(@mem_chart_data) %>">
        </canvas>
      </div>
      <p align="center" class="text-base md:text-lg">
        <strong>Memory Usage:</strong>
        <%= @used_memory %> / <%= @total_memory %> MiB
      </p>
    </div>
    """
  end
end
