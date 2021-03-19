defmodule PayAccount.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      PayAccount.Repo,
      # Start the Telemetry supervisor
      PayAccountWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: PayAccount.PubSub},
      # Start the Endpoint (http/https)
      PayAccountWeb.Endpoint
      # Start a worker by calling: PayAccount.Worker.start_link(arg)
      # {PayAccount.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PayAccount.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    PayAccountWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
