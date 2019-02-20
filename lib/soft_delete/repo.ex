defmodule SoftDelete.Repo do
  use Ecto.Repo,
    otp_app: :soft_delete,
    adapter: Ecto.Adapters.Postgres

  alias Ecto.{Adapters.SQL, Multi}

  def hard_delete(struct) do
    Multi.new()
    |> Multi.run(:disable_after_delete_trigger, fn repo, _ ->
      table = table_for(struct)
      query = "ALTER TABLE #{table} DISABLE TRIGGER #{table}_logical_delete_tg;"
      SQL.query(repo, query)
    end)
    |> Multi.delete(:delete, struct)
    |> Multi.run(:enable_after_delete_trigger, fn repo, _ ->
      table = table_for(struct)
      query = "ALTER TABLE #{table} ENABLE TRIGGER #{table}_logical_delete_tg;"
      SQL.query(repo, query)
    end)
    |> transaction()
  end

  defp table_for(%{__meta__: %{source: source}}), do: source
end
