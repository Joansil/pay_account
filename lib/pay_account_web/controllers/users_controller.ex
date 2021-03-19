defmodule PayAccountWeb.UsersController do
  use PayAccountWeb, :controller

  alias PayAccount.User

  action_fallback PayAccountWeb.FallbackController

  def create(conn, params) do
    with {:ok, %User{} = user} <- PayAccount.create_user(params) do
      conn
      |> put_status(:created)
      |> render("create.json", user: user)
    end
  end
end
