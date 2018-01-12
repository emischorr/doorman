defmodule Data.Repo.Migrations.CreateTenant do
  use Ecto.Migration

  def change do
    create table(:tenants) do
      add :code, :string, null: false
      add :name, :string

      timestamps()
    end

    create unique_index(:tenants, [:code])
  end
end
