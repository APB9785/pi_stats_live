defmodule PiStatsLive.SysInfo do
  def get_local_ip do
    case System.cmd("hostname", ["-I"]) do
      {local_ip, 0} ->
        String.trim_trailing(local_ip)
      _ ->
        "unable to lookup local IP"
    end
  end

  def get_hostname do
    case System.cmd("hostnamectl", []) do
      {results, 0} ->
        results
        |> String.split("\n")
        |> hd
        |> String.split(": ")
        |> Enum.at(1)
      _ ->
        "hostname unavailable"
    end
  end
end
