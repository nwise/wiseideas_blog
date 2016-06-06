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
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
