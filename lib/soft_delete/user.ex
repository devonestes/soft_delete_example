defmodule SoftDelete.User do
  use SoftDelete.Schema

  schema "users" do
    field(:name, :string)
    field(:deleted_at, :utc_datetime)
    timestamps()
  end

  def changeset(struct, attrs \\ %{}) do
    struct
    |> cast(attrs, [:id, :name])
    |> unique_constraint(:id, name: :users_pkey)
  end

  def undelete_changeset(struct) do
    cast(struct, %{deleted_at: nil}, [:deleted_at])
  end
end
