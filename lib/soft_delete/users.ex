defmodule SoftDelete.Users do
  alias SoftDelete.{Repo, User}

  import Ecto.Query

  def list_users() do
    Repo.all(User)
  end

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  def get_user(id) do
    Repo.get(User, id)
  end

  def update_user(user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  def delete_user(user) do
    case Repo.delete(user) do
      {:ok, user} -> {:ok, get_deleted_user(user.id)}
      result -> result
    end
  end

  def delete_all_users(query \\ User) do
    Repo.delete_all(query)
  end

  def list_deleted_users() do
    Repo.all(from(u in User, prefix: "public"))
  end

  def get_deleted_user(id) do
    Repo.get(from(u in User, prefix: "public"), id)
  end

  def undelete_user(user) do
    user
    |> User.undelete_changeset()
    |> Repo.update()
  end

  def hard_delete_user(user) do
    Repo.hard_delete(user)
  end
end
