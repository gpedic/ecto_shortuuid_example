defmodule ShortuuidExample.Repo do
  use Ecto.Repo,
    otp_app: :ecto_shortuuid_example,
    adapter: Ecto.Adapters.Postgres
end