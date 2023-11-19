defmodule Phoenix179Web.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      Phoenix179Web.Telemetry,
      # Start the Endpoint (http/https)
      Phoenix179Web.Endpoint
      # Start a worker by calling: Phoenix179Web.Worker.start_link(arg)
      # {Phoenix179Web.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Phoenix179Web.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    Phoenix179Web.Endpoint.config_change(changed, removed)
    :ok
  end
end
