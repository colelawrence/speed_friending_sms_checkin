defmodule SfSms.Friend do
  use SfSms.Web, :model

  schema "friends" do
    field :name, :string
    field :phone, :string
    field :verified, :boolean, default: false

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :phone, :verified])
    |> validate_required([:name, :phone, :verified])
  end
end
