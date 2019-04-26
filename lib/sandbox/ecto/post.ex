defmodule Sandbox.Ecto.Post do
  use Sandbox, :schema

  alias Sandbox.Ecto.{Comment, Author}

  defmodule Child do
    use Ecto.Schema

    embedded_schema do
      field :name, :string
      field :age, :integer
      field :pos, :integer
    end
  end

  schema "ecto_posts" do
    field :name, :string

    has_many :comments, Comment

    belongs_to :author, Author

    embeds_many :children, Child
    embeds_many :other_children, Child

    timestamps()
  end

  def changeset(struct, params) do
    chset =
      struct
      |> cast(params, [:name, :author_id])
      |> put_assoc(:comments, params.comments)
      |> cast_embed(:children, with: &child_changeset/2)
  end

  def child_changeset(struct, params) do
    struct
    |> cast(params, [:id, :name, :age, :pos])
  end
end
