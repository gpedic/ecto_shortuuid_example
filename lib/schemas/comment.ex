defmodule ShortuuidExample.Comment do
  use ShortuuidExample.Schema

  schema "comments" do
    field :content, :string
    field :parent_id, :integer
    belongs_to :post, ShortuuidExample.Post
    belongs_to :author, ShortuuidExample.User, foreign_key: :user_id
    belongs_to :parent, __MODULE__, foreign_key: :id, references: :parent_id, define_field: false
    has_many :children, __MODULE__, foreign_key: :parent_id, references: :id

    timestamps()
  end
end