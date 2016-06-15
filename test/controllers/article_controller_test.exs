defmodule WiseideasBlog.ArticleControllerTest do
  use WiseideasBlog.ConnCase

  alias WiseideasBlog.Article
  @valid_attrs %{author: "some content", body: "some content", publish_date: "2010-04-17", url: "some-url", title: "some content"}
  @invalid_attrs %{body: "some content"}

  test "loged-out users", %{conn: conn} do
    Enum.each([
      get(conn, article_path(conn, :new)),
      get(conn, article_path(conn, :edit, "123")),
      post(conn, article_path(conn, :create), article: %{}),
      put(conn, article_path(conn, :update, "123"),  article: %{}),
      delete(conn, article_path(conn, :delete, "123"))
    ],
    fn conn ->
      assert html_response(conn, 302)
      assert conn.halted
    end)
  end

  setup %{conn: conn} = config do
    if username = config[:login_as] do
      user = insert_user(username: username)
      conn = assign(conn(), :current_user, user)
      {:ok, conn: conn, user: user}
    else
      :ok
    end
  end

  @tag login_as: "nate"
  test "lists all entries on index", %{conn: conn} do
    conn = get conn, article_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing articles"
  end

  @tag login_as: "nate"
  test "renders form for new resources", %{conn: conn} do
    conn = get conn, article_path(conn, :new)
    assert html_response(conn, 200) =~ "New article"
  end

  @tag login_as: "nate"
  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, article_path(conn, :create), article: @valid_attrs
    assert redirected_to(conn) == article_path(conn, :index)
    assert Repo.get_by(Article, @valid_attrs)
  end

  @tag login_as: "nate"
  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, article_path(conn, :create), article: @invalid_attrs
    assert html_response(conn, 200) =~ "New article"
  end

  test "shows chosen resource", %{conn: conn} do
    {:ok, article} = insert_article()
    conn = get conn, article_path(conn, :show, article)
    assert html_response(conn, 200) =~ article.title
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, article_path(conn, :show, -1)
    end
  end

  @tag login_as: "nate"
  test "renders form for editing chosen resource", %{conn: conn} do
    article = Repo.insert! %Article{}
    conn = get conn, article_path(conn, :edit, article)
    assert html_response(conn, 200) =~ "Edit article"
  end

  @tag login_as: "nate"
  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    article = Repo.insert! %Article{}
    conn = put conn, article_path(conn, :update, article), article: @valid_attrs
    assert redirected_to(conn) == article_path(conn, :show, article)
    assert Repo.get_by(Article, @valid_attrs)
  end

  @tag login_as: "nate"
  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    article = Repo.insert! %Article{}
    conn = put conn, article_path(conn, :update, article), article: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit article"
  end

  @tag login_as: "nate"
  test "deletes chosen resource", %{conn: conn} do
    article = Repo.insert! %Article{}
    conn = delete conn, article_path(conn, :delete, article)
    assert redirected_to(conn) == article_path(conn, :index)
    refute Repo.get(Article, article.id)
  end
end
