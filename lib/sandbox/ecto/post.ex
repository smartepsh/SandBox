defmodule Sandbox.Ecto.Post do
  use Sandbox, :schema

  alias Sandbox.Ecto.{Comment, Author}

  schema "ecto_posts" do
    field :name, :string

    has_many :comments, Comment
    belongs_to :author, Author

    timestamps()
  end
end
