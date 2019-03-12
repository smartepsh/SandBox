defmodule Sandbox do
  @moduledoc """
  Sandbox keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """
  def schema do
    quote do
      use Ecto.Schema

      import Ecto.Query
      import Ecto.Changeset
      import Sandbox.EctoHelpers

      alias Sandbox.Repo

      @timestamps_opts [type: :naive_datetime_usec]
    end
  end

  def context do
    quote do
      import Ecto, only: [assoc: 2]
      import Ecto.Query
      import Ecto.Changeset
      alias Ecto.Multi
      alias Sandbox.Repo
    end
  end

  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
