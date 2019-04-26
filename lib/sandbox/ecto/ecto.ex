defmodule Sandbox.Ecto do
  use Sandbox, :context

  alias Sandbox.Ecto.Post

  def insert do
    Enum.map(1..100, fn num ->
      %{
        name: "post_#{num}",
        comments:
          Enum.map(1..5, fn idx ->
            %{
              name: "cmt_#{idx}",
              pos: String.to_integer("#{num}0#{idx}")
            }
          end)
      }
    end)
    |> Enum.each(fn params ->
      %Post{}
      |> Post.changeset(params)
      |> Repo.insert()
    end)
  end

  def list() do
    from(p in Post,
      join: c in Sandbox.Ecto.Comment,
      on: p.id == c.post_id,
      order_by: c.pos,
      select: p,
      distinct: true
    )
    |> Repo.all()
    |> Enum.map(& &1.name)
  end

  def get_post(id, preloads \\ []), do: Repo.get(Post, id) |> Repo.preload(preloads)

  def update(id) do
    %{children: [child_1, child_2]} = post = get_post(id, [:comments])

    post
    |> Post.changeset(%{children: [%{id: child_2.id}, %{id: child_1.id}]})
    |> Repo.update()
  end

  def embed_test do
    # %{children: children} = post = get_post(12)
    {:ok, %{children: children}} = post = insert()
  end
end
