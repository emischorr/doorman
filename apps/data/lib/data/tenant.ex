defmodule Data.Tenant do
  alias Ecto.Multi
  alias Data.Repo
  alias Data.Models.Tenant

  def get(id) do
    Tenant |> Tenant.by_id(id) |> Repo.one()
  end

  def find(code) do
    Tenant |> Tenant.by_code(code) |> Repo.one()
  end

  def new() do
    Tenant.changeset(%Tenant{})
  end

  def insert(params) do
    Tenant.changeset(%Tenant{}, params) |> Repo.insert
  end

  def edit(id) do
    tenant = get(id)
    changeset = Tenant.changeset(tenant)
    {tenant, changeset}
  end

  def update(id, params) do
    tenant = get(id)

    result = Multi.new
    |> Multi.update(:update_tenant, Tenant.changeset(tenant, params))
    |> Repo.transaction()

    case result do
      {:ok, %{update_tenant: tenant}} ->
        {:ok, tenant}
      {:error, changeset} -> {:error, tenant, changeset}
    end
  end

  def delete(id) do
    get(id) |> Repo.delete
  end

  def options do
    Tenant |> Repo.all() |> Enum.map(&{&1.name, &1.id})
  end
end
