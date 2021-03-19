defmodule PayAccountWeb.FallbackController do
  use PayAccountWeb, :controller

  def call(conn, {:error, reason}) do
    conn
    |> put_status(:bad_request)
    |> put_view(PayAccountWeb.ErrorView)
    |> render("400.json", reason: reason)
  end
end
