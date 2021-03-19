defmodule PayAccount.Accounts.Withdraw do
  alias PayAccount.Repo
  alias PayAccount.Accounts.Operation

  @spec call(map) :: {:error, any} | {:ok, any}
  def call(params) do
    params
    |> Operation.call(:withdraw)
    |> run_transaction()
  end

  defp run_transaction(run_multi) do
    case Repo.transaction(run_multi) do
      {:ok, %{withdraw: account}} -> {:ok, account}

      {:error, _operation, reason, _changes} -> {:error, reason}
    end
  end


end
