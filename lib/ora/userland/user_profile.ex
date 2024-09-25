defmodule Ora.Userland.UserProfile do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  embedded_schema do
    field :full_name, :string
    field :tg_handle, :string
    field :comments, :string
    field :grad_class, :string
    field :grad_year, :integer, default: 2014
  end

  @doc false
  def changeset(user, attrs) do
    # telegram handle
    user
    |> cast(attrs, [:full_name, :tg_handle, :comments, :grad_class, :grad_year])
    |> validate_inclusion(:grad_class, ["FN401", "FN402", "FN403","FN404", "LE401", "LE402", "LE403", "ML401", "ML402", "ML403", "MN401", "MN402", "MN403"])
    |> validate_length(:full_name, max: 88)
    |> validate_length(:comments, max: 150)
  end
end
