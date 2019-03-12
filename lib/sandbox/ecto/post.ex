defmodule Sandbox.Ecto.Post do
  use Sandbox, :schema

  alias Sandbox.Ecto.{Comment, Author}

  schema "ecto_posts" do
    field :name, :string

    has_many :comments, Comment
    belongs_to :author, Author

    timestamps()
  end

  def changeset(struct, params) do
    struct
    |> cast(params, [:name, :author_id])
    |> cast_assoc(:comments)
    |> set_position(:comments)
  end
end
