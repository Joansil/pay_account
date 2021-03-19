defmodule PayAccount.Accounts.Operation do
  alias Ecto.Multi
  alias PayAccount.Account

  def call(%{"id" => id, "value" => value}, operation) do
    op_name = action_account(operation)

    Multi.new()
    |> Multi.run(op_name, fn u_repo, _changes -> get_account(u_repo, id) end)
    |> Multi.run(operation, fn u_repo, changes ->
      account = Map.get(changes, op_name)
      update_balance(u_repo, account, value, operation)
    end)
  end

  defp get_account(u_repo, id) do
    case u_repo.get(Account, id) do
      nil -> {:error, "Account not found"}
      account -> {:ok, account}
    end
  end

  defp update_balance(u_repo, account, value, operation) do
    account
    |> actions(value, operation)
    |> update_account(u_repo, account)
  end

  defp actions(%Account{balance: balance}, value, operation) do
    value
    |> Decimal.cast()
    |> handle_action(balance, operation)
  end

  defp handle_action({:ok, value}, balance, :deposit), do: Decimal.add(balance, value)
  defp handle_action({:ok, value}, balance, :withdraw), do: Decimal.sub(balance, value)
  defp handle_action(:error, _balance, _operation), do: {:error, "Invalid deposit value"}

  defp update_account({:error, _reason} = error, _u_repo, _account), do: error

  defp update_account(value, u_repo, account) do
    params = %{balance: value}
    account
      |> Account.changeset(params)
      |> u_repo.update()
  end

  defp action_account(operation) do
    "account_#{Atom.to_string(operation)}"
    |> String.to_atom()
  end

end
