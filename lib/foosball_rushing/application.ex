defmodule FoosballRushing.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      # Disable DB for now
      # FoosballRushing.Repo,
      # Start the Telemetry supervisor
      FoosballRushingWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: FoosballRushing.PubSub},
      # Start the Endpoint (http/https)
      FoosballRushingWeb.Endpoint,
      # Start a worker by calling: FoosballRushing.Worker.start_link(arg)
      # {FoosballRushing.Worker, arg}
      # For caching
      # {Redix, host: "localhost", port: 6379, name: :redix}
      Supervisor.child_spec({Cachex, name: :player_cache}, id: :cachex_1),
      Supervisor.child_spec({Cachex, name: :csv_player_cache}, id: :cachex_2),

      # For updating the cache on a cadence
      FoosballRushingWeb.Scheduler
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: FoosballRushing.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    FoosballRushingWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
