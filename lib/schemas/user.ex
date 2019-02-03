defmodule ShortuuidExample.User do
  use ShortuuidExample.Schema

  schema "users" do
    field :name, :string
    field :age, :integer, default: 0
    has_many :posts, ShortuuidExample.Post

    timestamps()
  end
end