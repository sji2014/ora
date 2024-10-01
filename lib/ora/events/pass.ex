defmodule Ora.Events.Pass do
  use Ecto.Schema
  import Ecto.Changeset

  use Fsmx.Struct,
    state_field: :state,
    transitions: %{
      :* => ["gen"],
      :gen => "paid",
      :active => "attend"
    }

  @primary_key {:id, UUIDv7, autogenerate: true}
  @foreign_key_type :binary_id
  @timestamps_opts [type: :utc_datetime_usec]
  schema "passes" do
    field :state, Ecto.Enum, values: [gen: 0, paid: 1, attend: 2], default: :gen
    belongs_to :holder, Ora.Userland.User, references: :id, type: Ecto.UUID
    field :paid_at, :utc_datetime
    field :attend_at, :utc_datetime
    timestamps(type: :utc_datetime_usec)
  end

  @doc false
  def changeset(pass, attrs) do
    pass
    |> cast(attrs, [])
    |> validate_required([])
  end
end
