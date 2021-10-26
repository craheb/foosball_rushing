defmodule FoosballRushingWeb.PageController do
  use FoosballRushingWeb, :controller
  alias FoosballRushingWeb.FoosballRushingLive
  alias Phoenix.LiveView.Controller, as: LiveViewController

  def index(conn, %{}) do
    LiveViewController.live_render(conn, FoosballRushingLive,
      session: %{}
    )
  end
end
