defmodule PiStatsLiveWeb.TempChartComponent do
  @moduledoc """
  Temp chart
  """

  use PiStatsLiveWeb, :live_component

  def render(assigns) do
    ~L"""
    <div class="w-2/3 justify-self-center md:w-1/4">
      <div phx-update="ignore">
        <canvas id="temp-chart-canvas"
                phx-hook="TempChart"
                data-chart-data="<%= Jason.encode!(@temp_chart_data) %>">
        </canvas>
      </div>
      <p align="center" class="text-base md:text-lg">
        <strong>Current temp:</strong> <%= @cels %> °C / <%= @fahr %> °F
      </p>
    </div>
    """
  end
end
