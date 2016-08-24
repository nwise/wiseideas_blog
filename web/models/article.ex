defmodule WiseideasBlog.Article do
  use WiseideasBlog.Web, :model

  schema "articles" do
    field :title, :string
    field :url, :string
    field :body, :string
    field :publish_date, Ecto.Date
    field :author, :string

    timestamps
  end

  @required_fields ~w(title url body publish_date author)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ %{}) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end

  def published do
    query = from a in __MODULE__,
            where: a.published_date > Timex.Date.today
  end

  def months do
    query = from a in __MODULE__,
            select: fragment("DISTINCT to_char(publish_date, 'Mon, YYYY') AS MONTH")
    Repo.all(query)
  end
end
