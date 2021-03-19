defmodule PayAccount do
  alias PayAccount.Users.Create, as: UserCreate
  alias PayAccount.Accounts.{Deposit, Withdraw, Transfer}

  defdelegate create_user(params), to: UserCreate, as: :call

  defdelegate deposit(params), to: Deposit, as: :call

  defdelegate withdraw(params), to: Withdraw, as: :call

  defdelegate transfer(params), to: Transfer, as: :call

end
