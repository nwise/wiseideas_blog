defmodule WiseideasBlog.PageController do
  use WiseideasBlog.Web, :controller
  alias WiseideasBlog.Repo
  alias WiseideasBlog.Article

  def index(conn, _params) do
    articles = Repo.all(Article)
    months = Article.months
    render conn, "index.html", articles: articles, months: months
  end
end
