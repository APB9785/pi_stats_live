defmodule PiStatsLive.Disk do
  
  @empty %{:disk_total => 0, :disk_used => 0}

  def get_current do
    case System.cmd("df", []) do
    {str, 0} -> 
      parse_df(str)
      |> IO.inspect
    end
  end

  defp parse_df(input) do
    input
    |> String.split("\n", trim: true)
    |> tl
    |> Enum.reduce(@empty, &parse_single/2)
    |> convert_to_gb
  end

  defp parse_single(line, acc) do
    [filesys, size, used, _avail, _percent, _mount] =
      String.split(line, " ", trim: true)

    if filesys in ["tmpfs", "devtmpfs"] do
      acc
    else
      acc
      |> Map.update!(:disk_total, &(&1 + String.to_integer(size)))
      |> Map.update!(:disk_used, &(&1 + String.to_integer(used)))
    end
  end

  defp convert_to_gb(disk_map) do
    disk_map
    |> Map.update!(:disk_total, &Float.round(&1 / 1024 / 1024, 2))
    |> Map.update!(:disk_used, &Float.round(&1 / 1024 / 1024, 2))
  end
end

PiStatsLive.Disk.get_current()
