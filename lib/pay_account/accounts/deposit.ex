defmodule PayAccount.Accounts.Deposit do
  alias PayAccount.Repo
  alias PayAccount.Accounts.Operation

  def call(params) do
    params
    |> Operation.call(:deposit)
    |> run_transaction()
  end

  defp run_transaction(run_multi) do
    case Repo.transaction(run_multi) do
      {:ok, %{deposit: account}} -> {:ok, account}

      {:error, _operation, reason, _changes} -> {:error, reason}
    end
  end

end
