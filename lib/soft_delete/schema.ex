defmodule SoftDelete.Schema do
  @moduledoc """
  Module to be `use`-d in place of `Ecto.Schema` for all schemas.
  """

  defmacro __using__(_) do
    quote do
      use Ecto.Schema
      import Ecto.Changeset

      @schema_prefix "filtered"
    end
  end
end
