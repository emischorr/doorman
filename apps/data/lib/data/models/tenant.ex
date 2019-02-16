defmodule Data.Models.Tenant do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

  schema "tenants" do
    field :code, :string
    field :name, :string
    field :allow_subscription, :boolean, default: false

    has_many :users, Data.Models.User

    timestamps()
  end

  @required_fields ~w(code name)a
  @optional_fields ~w(allow_subscription)a

  def by_id(query, id) do
    from t in query,
    where: t.id == ^id
  end

  def by_code(query, code) do
    from t in query,
    where: t.code == ^code
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
    |> unique_constraint(:code)
    |> validate_length(:code, min: 3)
    |> validate_length(:name, min: 3)
  end

end
