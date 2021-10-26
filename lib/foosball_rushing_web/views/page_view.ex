defmodule FoosballRushingWeb.PageView do
  use FoosballRushingWeb, :view

  @possible_name_sort ["Yds", "Lng", "TD"]
  @possible_by_sort [:asc, :desc]

  @doc """
  Filter player by name
  """
  def filter_by_name(players, name) do
    players
    |> Enum.filter(fn x ->
      String.contains?(
        String.downcase(x["Player"]),
        String.downcase(name))
      end)
  end

  @doc """
  Sort players by column name
  """
  def sort(players, name \\ "Yds", by \\ :desc)
  def sort(players, name, by)
    when name in @possible_name_sort and by in @possible_by_sort do
    Enum.sort_by(players, &(&1[name]), by)
  end

  # Tried sorting by a value that wasn't possible.
  # Return same list, and possibly throw a log warning
  def sort(players, _name, _by) do
    players
  end
end
