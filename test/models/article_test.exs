defmodule WiseideasBlog.ArticleTest do
  use WiseideasBlog.ModelCase

  alias WiseideasBlog.Article

  @valid_attrs %{author: "some content", url: "test", body: "some content", publish_date: "2010-04-17", title: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Article.changeset(%Article{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Article.changeset(%Article{}, @invalid_attrs)
    refute changeset.valid?
  end
end
