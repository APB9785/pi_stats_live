defmodule PiStatsLiveWeb.ProcListComponent do
  @moduledoc """
  Process list
  """

  use PiStatsLiveWeb, :live_component

  def render(assigns) do
    ~L"""
    <div class="bg-white p-8 rounded-xl shadow-md">
      <h3 align="left" class="pb-4">Active Processes:</h3>
      <table>
        <tr>
          <th class="text-lg p-0">Name</th>
          <th class="text-lg p-0">Uptime</th>
          <th class="text-lg p-0">CPU Use</th>
          <th class="text-lg p-0">RAM Use</th>
        </tr>
        <%= for proc <- @process_list do %>
          <tr>
            <td class="text-lg p-0"><%= proc["name"] %></td>
            <td class="text-lg p-0"><%= proc["uptime"] %></td>
            <td class="text-lg p-0"><%= proc["cpu"] %> %</td>
            <td class="text-lg p-0"><%= proc["mem"] %> %</td>
          </tr>
        <% end %>
      </table>
    </div>
    """
  end
end
