use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :wiseideas_blog, WiseideasBlog.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :wiseideas_blog, WiseideasBlog.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "nathanwise",
  password: "",
  database: "wiseideas_blog_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
