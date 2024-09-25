defmodule Ora.Repo.Migrations.CreatePasses do
  use Ecto.Migration

  def change do
    create table(:passes, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :holder_id, references(:users, on_delete: :nothing, column: :id, type: :uuid)
      add :state, :integer

      timestamps(type: :utc_datetime_usec)
    end
  end
end
