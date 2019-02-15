defmodule Data.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :login, :string, null: false
      add :password_hash, :string, null: false
      add :name, :string
      add :lastname, :string
      add :email, :string
      add :active, :boolean, default: true
      add :last_login, :utc_datetime
      add :attributes, :map

      add :tenant_id, references(:tenants)

      timestamps()
    end

    create unique_index(:users, [:login, :tenant_id], name: :users_login_tenant_id_index)
  end
end
