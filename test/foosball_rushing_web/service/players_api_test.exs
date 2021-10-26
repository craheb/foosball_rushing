defmodule FoosballRushingWeb.Service.PlayersTest do
  use FoosballRushingWeb.ConnCase

  alias FoosballRushingWeb.Service.PlayersApi

  test "loading data with bad number data", _ do
    clean_data = PlayersApi.get_all_players_from_file("test/foosball_rushing_web/fixtures/bad_numbers.json")

    Enum.map(clean_data, fn player ->
      assert is_integer(player["Yds"])
      assert is_integer(player["Lng"])
      assert is_integer(player["TD"])
    end)
  end

  test "loading from cache", _ do
    Cachex.put(:player_cache, "players", [%{"Player" => "Lonely Player"}])

    players = PlayersApi.get_all_players_from_cache()

    assert Enum.count(players) == 1
  end

  test "loading from file", _ do
    Cachex.put(:player_cache, "players", nil)

    players = PlayersApi.get_all_players_from_cache()

    assert Enum.count(players) == 326
  end

  test "updating cache", _ do
    assert PlayersApi.update_cache() == {:ok, true}
  end


end
