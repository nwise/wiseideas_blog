defmodule WiseideasBlog.TestHelpers do
  alias WiseideasBlog.Repo

  def insert_user(attrs \\ %{}) do
    changes = Dict.merge(%{
      name: "Some User",
      username: "test-user",
      password: "Password1",
    }, attrs)

    %WiseideasBlog.User{}
    |> WiseideasBlog.User.registration_changeset(changes)
    |> Repo.insert!
  end

  def insert_article(attrs \\ %{}) do
    changes = Dict.merge(%{
      author: "Nate",
      body: "Main content here.",
      publish_date: "2010-04-17",
      title: "This is the title",
      url: "this-is-the-url"
    }, attrs)
 
    %WiseideasBlog.Article{}
    |> WiseideasBlog.Article.changeset(changes)
    |> Repo.insert
  end
end
