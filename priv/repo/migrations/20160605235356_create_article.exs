defmodule WiseideasBlog.Repo.Migrations.CreateArticle do
  use Ecto.Migration

  def change do
    create table(:articles) do
      add :title, :string
      add :url, :string
      add :body, :text
      add :publish_date, :date
      add :author, :string

      timestamps
    end
  end
end
