defmodule Sandbox.Ecto do
  use Sandbox, :context

  alias Sandbox.Ecto.Post

  def insert do
    params = %{
      name: "test_post",
      comments: Enum.map(1..5, &%{name: "comment-#{&1}"})
    }

    %Post{}
    |> Post.changeset(params)
    |> Repo.insert()
  end

  def get_post(id, preloads \\ []), do: Repo.get(Post, id) |> Repo.preload(preloads)

  def update(id) do
    post = get_post(id, [:comments])

    {pre_comments, suf_comments} = post.comments |> Enum.map(&Map.from_struct/1) |> Enum.split(2)

    mid_comment = [%{name: "mid_comment"}]

    comments = pre_comments ++ mid_comment ++ suf_comments

    post
    |> Post.changeset(%{comments: comments})
    |> Repo.update()
  end
end
