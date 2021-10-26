defmodule FoosballRushingWeb.CsvController do
  use FoosballRushingWeb, :controller

  def export(conn, _params) do
    conn
    |> put_resp_content_type("text/csv")
    |> put_resp_header("content-disposition", "attachment; filename=\"Players Stats.csv\"")
    |> send_resp(200, csv_content())
  end

  defp csv_content do
    # TODO: handle case where no players are in cache
    # TODO: filter player results to match column order of UI

    players = Cachex.get!(:csv_player_cache, "csv_players")

    # we dont need this anymore
    Cachex.purge(:csv_player_cache)

    header = Map.keys(List.first(players))
    results =
      players
      |> Enum.reduce([], fn player, acc ->
        acc ++ [Map.values(player)]
      end)

    [header] ++ results |> IO.inspect
    |> CSV.encode
    |> Enum.to_list
    |> to_string
  end
end
