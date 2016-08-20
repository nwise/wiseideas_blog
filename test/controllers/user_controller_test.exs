defmodule WiseideasBlog.UserControllerTest do
  use WiseideasBlog.ConnCase

  alias WiseideasBlog.User
  @valid_attrs %{name: "some content", password: "some content", username: "some content"}
  @invalid_attrs %{username: nil}

  test "loged-out users", %{conn: conn} do
    Enum.each([
      get(conn, user_path(conn, :index)),
      get(conn, user_path(conn, :new)),
      get(conn, user_path(conn, :edit, "123")),
      post(conn, user_path(conn, :create), user: %{}),
      put(conn, user_path(conn, :update, "123"),  user: %{}),
      delete(conn, user_path(conn, :delete, "123"))
    ],
    fn conn ->
      assert html_response(conn, 302)
      assert conn.halted
    end)
  end

  setup %{conn: conn} = config do
    if username = config[:login_as] do
      user = insert_user(username: username)
      conn = assign(build_conn, :current_user, user)
      {:ok, conn: conn, user: user}
    else
      :ok
    end
  end

  @tag login_as: "nate"
  test "lists all entries on index", %{conn: conn} do
    conn = get conn, user_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing users"
  end

  @tag login_as: "nate"
  test "renders form for new resources", %{conn: conn} do
    conn = get conn, user_path(conn, :new)
    assert html_response(conn, 200) =~ "New User"
  end

  @tag login_as: "nate"
  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, user_path(conn, :create), user: @valid_attrs
    assert redirected_to(conn) == user_path(conn, :index)
    assert Repo.get_by(User, name: @valid_attrs[:name])
  end

  @tag login_as: "nate"
  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, user_path(conn, :create), user: @invalid_attrs
    assert html_response(conn, 200) =~ "New User"
  end

  @tag login_as: "nate"
  test "shows chosen resource", %{conn: conn} do
    user = insert_user
    conn = get conn, user_path(conn, :show, user)
    assert html_response(conn, 200) =~ "Show User"
  end

  @tag login_as: "nate"
  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, user_path(conn, :show, -1)
    end
  end

  @tag login_as: "nate"
  test "renders form for editing chosen resource", %{conn: conn} do
    user = insert_user
    conn = get conn, user_path(conn, :edit, user)
    assert html_response(conn, 200) =~ "Edit User"
  end

  @tag login_as: "nate"
  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    user = insert_user
    conn = put conn, user_path(conn, :update, user), user: @valid_attrs
    assert redirected_to(conn) == user_path(conn, :show, user)
    assert Repo.get_by(User, name: @valid_attrs[:name])
  end

  @tag login_as: "nate"
  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    user = insert_user(username: "frank")
    conn = put conn, user_path(conn, :update, user), user: @invalid_attrs
    assert html_response(conn, 200) =~ "Oops, something went wrong!"
  end
end
