# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
alias Data.Repo
alias Data.Models.{Tenant, User}

# Basic Data
IO.puts "== Seeding Database =="

{:ok, admin_tenant} = Repo.insert(%Tenant{
  code: "admin",
  name: "Admin",
}, on_conflict: :nothing)

admin_user_change = User.changeset(%User{}, %{
  name: "Admin",
  login: "admin",
  password: "admin",
  tenant_id: admin_tenant.id
})
admin_user = Repo.insert(admin_user_change, on_conflict: :nothing)
