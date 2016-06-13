require IEx
defmodule WiseideasBlog.ArticleView do
  use WiseideasBlog.Web, :view
  use Timex

  # TODO: Make different date formats
  def format_date(date) do
    {:ok, date} = Ecto.Date.dump(date)
    Timex.Date.from(date)
    |> Timex.format!("%B %e, %Y", :strftime)
  end
end
