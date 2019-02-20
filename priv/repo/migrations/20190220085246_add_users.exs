defmodule SoftDelete.Repo.Migrations.AddUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add(:name, :string)

      timestamps()
    end

    execute(
      """
      DO $$
      BEGIN
        PERFORM prepare_table_for_soft_delete('users');
      END $$
      """,
      """
      DO $$
      BEGIN
        PERFORM reverse_table_soft_delete('users');
      END $$
      """
    )
  end
end
