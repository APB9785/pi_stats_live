defmodule PiStatsLiveWeb.SystemComponent do
  @moduledoc """
  Header box with system info
  """

  use PiStatsLiveWeb, :live_component

  def render(assigns) do
    ~L"""
    <div class="flex justify-center">
      <div class="my-2 md:mt-12 py-6 bg-gray-300 rounded-xl shadow-md w-full md:w-1/2">
        <div class="grid justify-center">
          <div class="font-bold mb-4">
            <%= @hostname %> - <%= @local_ip %>
          </div>
          <div>
            Current Time: <%= @current_time %> CST
          </div>
          <div>
            System uptime: <%= @uptime %>
          </div>
          <div>
            HD/SD Usage: <%= @disk_used %> / <%= @disk_total %> GiB
          </div>
        </div>
      </div>
    </div>
    """
  end
end
