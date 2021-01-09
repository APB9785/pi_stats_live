defmodule PiStatsLive.Repo do
  use Ecto.Repo,
    otp_app: :pi_stats_live,
    adapter: Ecto.Adapters.Postgres
end
