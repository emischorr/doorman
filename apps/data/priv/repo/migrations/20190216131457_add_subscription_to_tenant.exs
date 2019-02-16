defmodule Data.Repo.Migrations.AddSubscriptionToTenant do
  use Ecto.Migration

  def change do
    alter table(:tenants) do
      add :allow_subscription, :boolean, default: false
    end
  end
end
