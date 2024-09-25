defmodule Ora.EventsTest do
  use Ora.DataCase

  alias Ora.Events

  describe "passes" do
    alias Ora.Events.Pass

    import Ora.EventsFixtures

    @invalid_attrs %{}

    test "list_passes/0 returns all passes" do
      pass = pass_fixture()
      assert Events.list_passes() == [pass]
    end

    test "get_pass!/1 returns the pass with given id" do
      pass = pass_fixture()
      assert Events.get_pass!(pass.id) == pass
    end

    test "create_pass/1 with valid data creates a pass" do
      valid_attrs = %{}

      assert {:ok, %Pass{} = pass} = Events.create_pass(valid_attrs)
    end

    test "create_pass/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Events.create_pass(@invalid_attrs)
    end

    test "update_pass/2 with valid data updates the pass" do
      pass = pass_fixture()
      update_attrs = %{}

      assert {:ok, %Pass{} = pass} = Events.update_pass(pass, update_attrs)
    end

    test "update_pass/2 with invalid data returns error changeset" do
      pass = pass_fixture()
      assert {:error, %Ecto.Changeset{}} = Events.update_pass(pass, @invalid_attrs)
      assert pass == Events.get_pass!(pass.id)
    end

    test "delete_pass/1 deletes the pass" do
      pass = pass_fixture()
      assert {:ok, %Pass{}} = Events.delete_pass(pass)
      assert_raise Ecto.NoResultsError, fn -> Events.get_pass!(pass.id) end
    end

    test "change_pass/1 returns a pass changeset" do
      pass = pass_fixture()
      assert %Ecto.Changeset{} = Events.change_pass(pass)
    end
  end
end
