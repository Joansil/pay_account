defmodule PayAccount.Repo do
  use Ecto.Repo,
    otp_app: :pay_account,
    adapter: Ecto.Adapters.Postgres
end
