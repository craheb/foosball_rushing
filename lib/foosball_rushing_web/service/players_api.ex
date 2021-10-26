defmodule FoosballRushingWeb.Service.PlayersApi do

  @doc """
  Get all players from cache, otherwise pull from file
  """
  def get_all_players_from_cache() do
    players_cache = Cachex.get!(:player_cache, "players")
    if players_cache do
      IO.puts "Data loading from cache"
      players_cache
    else
      IO.puts "Data loading from api"
      players = get_all_players_from_file("rushing.json")
      Cachex.put(:player_cache, "players", players)

      players
    end
  end

  @doc """
  Gets fresh data from api and puts into cache
  """
  def update_cache do
    IO.puts "Updating cache: #{DateTime.utc_now()}"
    players = get_all_players_from_file("rushing.json")
    Cachex.put(:player_cache, "players", players)
  end

  @doc """
  Get all players from JSON file
  """
  def get_all_players_from_file(filename) do

    {:ok, body} = File.read(filename)
    # TODO: catch this with errors also
    {:ok, json} = Poison.decode(body)

    clean_data(json)
  end

  # Convert data to proper number format
  # Ideally, if we have control of the data, it would be clean before we put it in our DB
  defp clean_data(json) do
    clean_players = Enum.map(json, fn player ->
      player
        |> Map.update!("Yds", fn yds -> cleanNumber(yds) end)
        |> Map.update!("Lng", fn lng -> cleanNumber(lng) end)
        |> Map.update!("TD", fn td -> cleanNumber(td) end)
    end)

    clean_players
  end

  defp cleanNumber(name) when is_bitstring(name) do
    name
    |> String.replace(~r/[^\d]/, "")
    |> String.to_integer
  end
  defp cleanNumber(name) do
    name
  end

end
