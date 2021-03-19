defmodule PayAccount.Users.Create do
  alias Ecto.Multi
  alias PayAccount.{Account, Repo, User}

  def call(params) do
    Multi.new()
    |> Multi.insert(:create_user, User.changeset(params))
    |> Multi.run(:create_account, fn u_repo, %{create_user: user} ->
      insert_account(u_repo, user)
    end)
    |> Multi.run(:preload_data, fn u_repo, %{create_user: user} ->
      preload_data(u_repo, user)
    end)
    |> run_transaction()
  end

  defp account_changeset(user_id) do
    params = %{user_id: user_id, balance: "0.00"}
    Account.changeset(params)
  end

  defp insert_account(u_repo, user) do
    user.id
    |> account_changeset()
    |> u_repo.insert()
  end

  defp run_transaction(run_multi) do
    case Repo.transaction(run_multi) do
      {:ok, %{preload_data: user}} -> {:ok, user}

      {:error, _operation, reason, _changes} -> {:error, reason}
    end
  end

  defp preload_data(u_repo, user) do
    {:ok, u_repo.preload(user, :account)}
  end
end
