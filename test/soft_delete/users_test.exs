defmodule SoftDelete.UsersTest do
  use SoftDelete.DataCase, async: true

  alias SoftDelete.Users

  describe "delete_user/1" do
    test "soft deletes a user in the database" do
      {:ok, user} = Users.create_user()
      {:ok, _} = Users.delete_user(user)

      assert [] = Users.list_users()
      assert nil == Users.get_user(user.id)

      assert {:error, _} = Users.create_user(%{id: user.id})

      assert_raise Ecto.StaleEntryError, fn ->
        Users.update_user(user, %{name: "name"})
      end

      assert_raise Ecto.StaleEntryError, fn ->
        Users.delete_user(user)
      end

      assert [soft_deleted_user] = Users.list_deleted_users()
      assert users_equal?(user, soft_deleted_user)
    end
  end

  describe "delete_all_users/1" do
    test "soft deletes all users in the database" do
      {:ok, user} = Users.create_user()
      assert {1, nil} = Users.delete_all_users()

      assert [] = Users.list_users()
      assert nil == Users.get_user(user.id)

      assert {:error, _} = Users.create_user(%{id: user.id})

      assert_raise Ecto.StaleEntryError, fn ->
        Users.update_user(user, %{name: "name"})
      end

      assert_raise Ecto.StaleEntryError, fn ->
        Users.delete_user(user)
      end

      assert [soft_deleted_user] = Users.list_deleted_users()
      assert users_equal?(user, soft_deleted_user)
    end
  end

  describe "undelete_user/1" do
    test "undoes a soft delete on a user in the database" do
      {:ok, user} = Users.create_user()
      {:ok, user} = Users.delete_user(user)

      assert [] = Users.list_users()

      {:ok, user} = Users.undelete_user(user)

      assert [new_user] = Users.list_users()
      assert users_equal?(user, new_user)
    end
  end

  describe "hard_delete_user/1" do
    test "completely deletes a user from the database" do
      {:ok, user} = Users.create_user()
      {:ok, user} = Users.delete_user(user)
      {:ok, _} = Users.hard_delete_user(user)

      assert [] = Users.list_deleted_users()

      {:ok, user} = Users.create_user()
      {:ok, _} = Users.delete_user(user)
      assert [_] = Users.list_deleted_users()
    end
  end

  defp users_equal?(left, right) do
    left.id == right.id and left.name == right.name
  end
end
