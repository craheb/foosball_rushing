defmodule FoosballRushingWeb.FoosballRushingLive do
  @moduledoc "The LiveView for the main stats page"
  use Phoenix.LiveView


  alias FoosballRushingWeb.PageView
  alias FoosballRushingWeb.Service.PlayersApi

  def render(assigns) do
    PageView.render("index.html", assigns)
  end

  def mount(_session, _, socket) do
    players = PlayersApi.get_all_players_from_cache()

    socket =
      socket
      |> assign(:players, players)
      |> assign(:all_players, players)
      |> assign(:search_name, "")

      {:ok, socket}
  end

  # Filter players when searching
  def handle_event("filter_players", name, socket) do
    filtered_players =
      socket.assigns.all_players
      |> PageView.filter_by_name(name["value"])

    socket =
      socket
      |> assign(:players, filtered_players)
      |> assign(:search_name, name["value"])

    {:noreply, socket}
  end

  # Sort players by column name
  def handle_event("sort", %{"name" => name, "by" => by}, socket) do
    sorted_players =
      socket.assigns.players
      |> PageView.sort(name, String.to_atom(by))

    all_players =
      socket.assigns.all_players
      |> PageView.sort(name, String.to_atom(by))

    socket =
      socket
      |> assign(:players, sorted_players)
      |> assign(:all_players, all_players)
    {:noreply, socket}
  end

  def handle_event("download_csv", _, socket) do
    # store filtered/sorted players in cache to use on teh download controller
    Cachex.put(:csv_player_cache, "csv_players", socket.assigns.players)

    {:noreply,
    socket
    |> redirect(to: "/download_csv")}
  end
end
