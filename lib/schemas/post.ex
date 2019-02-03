defmodule ShortuuidExample.Post do
  use ShortuuidExample.Schema

  schema "posts" do
    field :title, :string
    belongs_to :user, ShortuuidExample.User
    has_many :comments, ShortuuidExample.Comment

    timestamps()
  end
end