defmodule Ora.EventsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Ora.Events` context.
  """

  @doc """
  Generate a pass.
  """
  def pass_fixture(attrs \\ %{}) do
    {:ok, pass} =
      attrs
      |> Enum.into(%{})
      |> Ora.Events.create_pass()

    pass
  end
end
