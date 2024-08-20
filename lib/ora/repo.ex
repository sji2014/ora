defmodule Ora.Repo do
  use Ecto.Repo,
    otp_app: :ora,
    adapter: Ecto.Adapters.Postgres
end
