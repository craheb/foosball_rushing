defmodule FoosballRushingWeb.PageControllerTest do
  use FoosballRushingWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Rushing Stats"
  end
end
