defmodule PayAccountWeb.AccountsView do
  alias PayAccount.Account
  alias PayAccount.Accounts.Transactions.Struct, as: Struct


  def render("update.json", %{account: %Account{id: account_id, balance: balance}}) do
    %{
      message: "Balance updated successfully!",
      account: %{
        id: account_id,
          balance: balance
      }
    }
  end

  def render("transfer.json", %{
    transfer: %Struct{from_account: from_account, to_account: to_account}}) do
      %{
        message: "Transfer done successfully",
        transfer: %{
          from_account: %{
            id: from_account.id,
            balance: from_account.balance
          },
          to_account: %{
            id: to_account.id,
            balance: to_account.balance
          }
        }
     }
  end

end
