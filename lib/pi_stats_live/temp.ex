defmodule PiStatsLive.Temp do
  def get_current do
    case System.cmd("vcgencmd", ["measure_temp"]) do
      {temp_str, 0} ->
        Regex.run(~r/[0-9.]+/, temp_str)
        |> hd
        |> Float.parse
        |> elem(0)
      _ -> "unavailable"
    end 
  end
end
