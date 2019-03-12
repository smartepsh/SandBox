defmodule Sandbox.Ecto.Tag do
  use Sandbox, :schema

  schema "ecto_tags" do
    field :name, :string
  end
end
