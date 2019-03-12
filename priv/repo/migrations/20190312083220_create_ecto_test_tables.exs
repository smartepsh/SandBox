defmodule Sandbox.Repo.Migrations.CreateEctoTestTables do
  use Ecto.Migration

  def change do
    create table(:ecto_authors) do
      add :name, :string
      timestamps()
    end

    create table(:ecto_posts) do
      add :author_id, references(:ecto_authors)
      add :name, :string
      timestamps()
    end

    create table(:ecto_tags) do
      add :name, :string
    end

    create table(:ecto_comments) do
      add :name, :string
      add :pos, :integer
      add :post_id, references(:ecto_posts)
      add :author_id, references(:ecto_authors)
      timestamps()
    end
  end
end
