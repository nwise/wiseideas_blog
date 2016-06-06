defmodule WiseideasBlog.Router do
  use WiseideasBlog.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug WiseideasBlog.Auth, repo: WiseideasBlog.Repo
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", WiseideasBlog do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/articles", ArticleController
    resources "/users", UserController
    resources "/sessions", SessionController, only: [:new, :create, :delete]
  end
end
