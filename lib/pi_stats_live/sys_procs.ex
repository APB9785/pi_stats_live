defmodule PiStatsLive.SysProcs do
  def get_current do
    # Add command "Upi" to show only user pi
    case System.cmd("top", ["-i", "-b", "-n1"]) do
      {"", 1} ->
        %{}
      {str, 0} ->
        str
        |> String.split("\n", trim: true)
        |> parse_top
    end
  end

  def parse_top([times, _tasks, cpu, mem, _swap, _headers | processes]) do
    {current_time, uptime, _users, _load_1m, _load_5m, _load_15m} =
      times
      |> String.split(" ", trim: true)
      |> parse_times

    # [_, tasks, _, running, _, sleeping, _, stopped, _, zombie, _] =
    #   String.split(tasks, " ", trim: true)

    [_, _us_cpu, _, _sy_cpu, _, _ni_cpu, _, id_cpu, _, _wa_cpu, _, _hi_cpu, _, _si_cpu, _, _st_cpu, _] =
      String.split(cpu, " ", trim: true)

    [_, _, _, total_mem, _, _free_mem, _, used_mem, _, _buffer_mem, _] =
      String.split(mem, " ", trim: true)

    # [_, _, _, _, free_swap, _, used_swap, _, swap_total, _, _] =
    #   String.split(swap, " ", trim: true)

    {total_mem, _} = Float.parse(total_mem)
    {used_mem, _} = Float.parse(used_mem)

    # Unused assigns
    # user_count: users,
    # avg_load_1m: String.slice(load_1m, 0..-2),
    # avg_load_5m: String.slice(load_5m, 0..-2),
    # avg_load_15m: load_15m,
    # total_tasks: tasks,
    # running_tasks: running,
    # sleeping_tasks: sleeping,
    # stopped_tasks: stopped,
    # zombie_tasks: zombie,
    # free_memory: free_mem,
    # buffer_memory: buffer_mem,
    # free_swap_percent: free_swap,
    # used_swap_percent: used_swap,
    # swap_total_size: swap_total,

    [
      current_time: current_time,
      uptime: uptime,
      cpu_usage: format_cpu(id_cpu),
      total_memory: total_mem,
      used_memory: used_mem,
      process_list: Enum.map(processes, &parse_process/1)
    ]
  end

  def format_cpu(id_cpu) do
    id_cpu
    |> Float.parse
    |> elem(0)
    |> (fn x -> 100 - x end).()
    |> Float.round(1)
    |> Float.to_string
  end

  def parse_times([_, _, current_time, _ | rest]) do
    {uptime, [users, _, _, _, load_1m, load_5m, load_15m]} =
      Enum.split(rest, -7)

    uptime =
      uptime
      |> Enum.join
      |> String.replace(",", " ")

    {current_time, uptime, users, load_1m, load_5m, load_15m}
  end

  def parse_process(line) do
    [cpu, mem, uptime, name] =
      String.split(line, " ", trim: true)
      |> Enum.drop(8)

    cpu =
      cpu
      |> Float.parse
      |> elem(0)
      |> (fn x -> x / 4 end).()
      |> Float.round(1)
      |> Float.to_string

    %{"cpu" => cpu, "mem" => mem, "uptime" => uptime, "name" => name}
  end
end
