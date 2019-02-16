defmodule Data.Models.User do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

  schema "users" do
    field :login, :string
    field :password_hash, :string
    field :password, :string, virtual: true
    field :name, :string
    field :lastname, :string
    field :email, :string
    field :active, :boolean, default: true
    field :last_login, :utc_datetime
    field :attributes, :map

    belongs_to :tenant, Data.Models.Tenant

    timestamps()
  end

  @required_fields ~w(login, tenant_id)a
  @optional_fields ~w(password name lastname email active attributes)a

  def by_id(query, id) do
    from u in query,
    where: u.id == ^id
  end

  def by_login(query, login) do
    from u in query,
    where: u.login == ^login
  end

  def active(query) do
    from u in query,
    where: u.active == true
  end

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ %{}) do
    model
    |> cast(params, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> validate_length(:name, min: 3)
    |> validate_format(:email, ~r/@/)
    |> validate_length(:password, min: 5)
    |> validate_confirmation(:password, message: "Password does not match")
    |> unique_constraint(:login, name: :users_login_tenant_id_index, message: "Login already taken")
    |> hash_password()
  end

  defp hash_password(%{changes: %{password: password}} = changeset) do
    put_change(changeset, :password_hash, Comeonin.Bcrypt.hashpwsalt(password))
  end
  defp hash_password(%{changes: %{}} = changeset), do: changeset

end
