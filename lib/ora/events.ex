defmodule Ora.Events do
  @moduledoc """
  The Events context.
  """

  import Ecto.Query, warn: false
  alias Ora.Repo

  alias Ora.Events.Pass

  @doc """
  Returns the list of passes.

  ## Examples

      iex> list_passes()
      [%Pass{}, ...]

  """
  def list_passes do
    Repo.all(Pass)
  end

  @doc """
  Gets a single pass.

  Raises `Ecto.NoResultsError` if the Pass does not exist.

  ## Examples

      iex> get_pass!(123)
      %Pass{}

      iex> get_pass!(456)
      ** (Ecto.NoResultsError)

  """
  def get_pass!(id), do: Repo.get!(Pass, id)

  @doc """
  Creates a pass.

  ## Examples

      iex> create_pass(%{field: value})
      {:ok, %Pass{}}

      iex> create_pass(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_pass(attrs \\ %{}) do
    %Pass{}
    |> Pass.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a pass.

  ## Examples

      iex> update_pass(pass, %{field: new_value})
      {:ok, %Pass{}}

      iex> update_pass(pass, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_pass(%Pass{} = pass, attrs) do
    pass
    |> Pass.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a pass.

  ## Examples

      iex> delete_pass(pass)
      {:ok, %Pass{}}

      iex> delete_pass(pass)
      {:error, %Ecto.Changeset{}}

  """
  def delete_pass(%Pass{} = pass) do
    Repo.delete(pass)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking pass changes.

  ## Examples

      iex> change_pass(pass)
      %Ecto.Changeset{data: %Pass{}}

  """
  def change_pass(%Pass{} = pass, attrs \\ %{}) do
    Pass.changeset(pass, attrs)
  end
end
