defmodule FoosballRushingWeb.PageViewTest do
  use FoosballRushingWeb.ConnCase, async: true

  alias FoosballRushingWeb.PageView

  @mock_players [
    %{"Player" => "Bob", "Yds" => 3, "Lng" => 50, "TD" => 4},
    %{"Player" => "Frank", "Yds" => 2, "Lng" => 45, "TD" => 8},
    %{"Player" => "Bobbette", "Yds" => 1, "Lng" => 99, "TD" => 2}
  ]

  test "filter players by name", _ do
    players = @mock_players

    filtered_players = PageView.filter_by_name(players, "bob")
    assert Enum.count(filtered_players) == 2

    filtered_players = PageView.filter_by_name(players, "frank")
    assert Enum.count(filtered_players) == 1

    filtered_players = PageView.filter_by_name(players, "nope")
    assert Enum.count(filtered_players) == 0
  end

  test "sort players by Yards", _ do
    players = @mock_players

    sorted_players = PageView.sort(players, "Yds", :asc)
    assert List.first(sorted_players)["Player"] == "Bobbette"

    sorted_players = PageView.sort(players, "Yds", :desc)
    assert List.first(sorted_players)["Player"] == "Bob"
  end

  test "sort players by Lng", _ do
    players = @mock_players

    sorted_players = PageView.sort(players, "Lng", :desc)
    assert List.first(sorted_players)["Player"] == "Bobbette"

    sorted_players = PageView.sort(players, "Lng", :asc)
    assert List.first(sorted_players)["Player"] == "Frank"
  end

  test "sort players by TD", _ do
    players = @mock_players

    sorted_players = PageView.sort(players, "TD", :desc)
    assert List.first(sorted_players)["Player"] == "Frank"

    sorted_players = PageView.sort(players, "TD", :asc)
    assert List.first(sorted_players)["Player"] == "Bobbette"
  end

  test "sort players by BAD sorting column", _ do
    players = @mock_players

    sorted_players = PageView.sort(players, "BAD", :asc)
    assert List.first(sorted_players)["Player"] == "Bob"

    sorted_players = PageView.sort(players, "VERYBAD", :desc)
    assert List.first(sorted_players)["Player"] == "Bob"
  end

  test "sort players default", _ do
    players = @mock_players

    sorted_players = PageView.sort(players)
    assert List.first(sorted_players)["Player"] == "Bob"
  end
end
