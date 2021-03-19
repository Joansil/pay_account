defmodule PayAccountWeb.AccountsController do
  use PayAccountWeb, :controller

  alias PayAccount.Account
  alias PayAccount.Accounts.Transactions.Struct, as: Struct

  action_fallback PayAccountWeb.FallbackController

  def deposit(conn, params) do
    with {:ok, %Account{} = account} <- PayAccount.deposit(params) do
      conn
      |> put_status(:ok)
      |> render("update.json", account: account)
    end
  end

  def withdraw(conn, params) do
    with {:ok, %Account{} = account} <- PayAccount.withdraw(params) do
      conn
      |> put_status(:ok)
      |> render("update.json", account: account)
    end
  end

  def transfer(conn, params) do
    with {:ok, %Struct{} = transfer} <- PayAccount.transfer(params) do
      conn
      |> put_status(:ok)
      |> render("transfer.json", transfer: transfer)
    end
  end
end
