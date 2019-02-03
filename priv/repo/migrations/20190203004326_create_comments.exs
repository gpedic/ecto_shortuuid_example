defmodule ShortuuidExample.Repo.Migrations.CreateComments do
  use Ecto.Migration

  def change do
    create table("comments") do
      add :content, :text
      add :parent_id, references(:comments)
      add :post_id, references(:posts)
      add :user_id, references(:users)

      timestamps()
    end
  end
end
