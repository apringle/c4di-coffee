defmodule C4diCoffeeWeb.SummaryControllerTest do
  use C4diCoffeeWeb.ConnCase

  alias C4diCoffeeWeb.Summary
  @valid_attrs %{avg_cup_size: 42, fill_level: 42, pot_name: "some content", time: "2010-04-17 14:00:00"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, summary_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    summary = Repo.insert! %Summary{}
    conn = get conn, summary_path(conn, :show, summary)
    assert json_response(conn, 200)["data"] == %{"id" => summary.id,
      "pot_name" => summary.pot_name,
      "time" => summary.time,
      "fill_level" => summary.fill_level,
      "avg_cup_size" => summary.avg_cup_size}
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, summary_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, summary_path(conn, :create), summary: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Summary, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, summary_path(conn, :create), summary: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    summary = Repo.insert! %Summary{}
    conn = put conn, summary_path(conn, :update, summary), summary: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Summary, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    summary = Repo.insert! %Summary{}
    conn = put conn, summary_path(conn, :update, summary), summary: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    summary = Repo.insert! %Summary{}
    conn = delete conn, summary_path(conn, :delete, summary)
    assert response(conn, 204)
    refute Repo.get(Summary, summary.id)
  end
end
