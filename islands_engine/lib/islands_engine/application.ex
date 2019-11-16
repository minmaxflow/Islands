defmodule IslandsEngine.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      {Registry, keys: :unique, name: Registry.Game},
      IslandsEngine.GameSupervisor
    ]

    # 支持process的状态恢复
    # {:ok, game} = GameSupervisor.start_game("p1")
    # via = Game.via_tuple("p1")
    # :sys.get_state(via)
    # Process.alive?(game)
    # Process.exit(game, :kaboom)
    # :sys.get_state(via), game指向的Process已经dead
    :ets.new(:game_state, [:public, :named_table])

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: IslandsEngine.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
