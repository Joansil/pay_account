defmodule PayAccount.Accounts.Transfer do
  alias Ecto.Multi
  alias PayAccount.Repo
  alias PayAccount.Accounts.Operation
  alias PayAccount.Accounts.Transactions.Struct, as: Struct

  def call(%{"from" => from_id, "to" => to_id, "value" => value}) do
    withdraw_params = params_operation(from_id, value)
    deposit_params = params_operation(to_id, value)

    Multi.new()
    |> Multi.merge(fn _changes -> Operation.call(withdraw_params, :withdraw) end)
    |> Multi.merge(fn _changes -> Operation.call(deposit_params, :deposit) end)
    |> run_transaction
  end

  defp params_operation(id, value), do: %{"id" => id, "value" => value}

  defp run_transaction(run_multi) do
    case Repo.transaction(run_multi) do
      {:ok, %{deposit: to_account, withdraw: from_account}} ->
        {:ok, Struct.build(from_account, to_account)}

      {:error, _operation, reason, _changes} -> {:error, reason}
    end
  end
end
