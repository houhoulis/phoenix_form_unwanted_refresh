defmodule Phoenix179.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      # Phoenix179.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Phoenix179.PubSub},
      # Start Finch
      {Finch, name: Phoenix179.Finch}
      # Start a worker by calling: Phoenix179.Worker.start_link(arg)
      # {Phoenix179.Worker, arg}
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: Phoenix179.Supervisor)
  end
end
