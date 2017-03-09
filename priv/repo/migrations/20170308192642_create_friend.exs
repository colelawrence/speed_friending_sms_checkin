defmodule SpeedfriendingSms.Repo.Migrations.CreateFriend do
  use Ecto.Migration

  def change do
    create table(:friends) do
      add :name, :string
      add :phone, :string
      add :verified, :boolean, default: false, null: false

      timestamps()
    end

  end
end
