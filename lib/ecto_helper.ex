defmodule Sandbox.EctoHelpers do
  import Ecto.Changeset

  def set_position(%{valid?: true, changes: changes} = changeset, key) do
    case get_change(changeset, key) do
      nil ->
        changeset

      item_chsets ->
        {replace_chsets, update_chsets} = Enum.split_with(item_chsets, &(&1.action == :replace))

        update_chsets =
          update_chsets
          |> Enum.with_index(1)
          |> Enum.map(fn {chset, pos} ->
            put_change(chset, :pos, pos)
          end)

        %{changeset | changes: Map.put(changes, key, replace_chsets ++ update_chsets)}
    end
  end

  def set_position(changeset, _key), do: changeset
end
