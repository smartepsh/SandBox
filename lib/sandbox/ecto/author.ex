defmodule Sandbox.Ecto.Author do
  use Sandbox, :schema

  alias Sandbox.Ecto.Post

  schema "ecto_authors" do
    field :name, :string
    has_many :posts, Post
    timestamps()
  end
end
