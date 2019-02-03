use Mix.Config

config :ecto_shortuuid_example, ecto_repos: [ShortuuidExample.Repo]

config :ecto_shortuuid_example, ShortuuidExample.Repo,
  # edit the connection string in case you want to use your own db setup
  url: "postgres://postgres:postgres@localhost:5433/example",

  # this setting makes it so we don't need to explicitly define
  # id's in migrations to be binary_id's
  # https://hexdocs.pm/ecto_sql/Ecto.Migration.html#module-repo-configuration
  migration_primary_key: [name: :id, type: :binary_id]