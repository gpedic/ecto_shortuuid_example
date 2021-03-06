defmodule ShortuuidExample.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table("posts") do
      add :title, :string, default: "Untitled"
      add :summary, :text
      add :user_id, references(:users)

      timestamps()
    end
  end
end
