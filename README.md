# PiStatsLive
   
v0.2 - Added Clock, uptime, CPU and RAM usage, and table of active processes   
v0.1 - Shows real-time temperature in Celsius and Fahrenheit   
   
To start the server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Install Node.js dependencies with `npm install` inside the `assets` directory
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit http://[raspberry pi IP]:4000/stats from any device on the local network.
