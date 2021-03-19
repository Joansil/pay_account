defmodule PayAccountWeb.AccountsControllerTest do
  use PayAccountWeb.ConnCase, async: true

  alias PayAccount.{Account, User}

  describe "deposit/2" do
    setup %{conn: conn} do
      user =  %{
        name: "Chikko Pankika",
        age: 45,
        password: "123456",
        nickname: "Chikko",
        email: "chikko@gmail.com"
      }

      {:ok, %User{account: %Account{id: account_id}}} = PayAccount.create_user(user)

      conn = put_req_header(conn, "authorization", "Basic dXNlcjp1c2Vy")

      {:ok, conn: conn, account_id: account_id}
    end

    test "when all params is valid, deposit it", %{conn: conn, account_id: account_id} do
      value = %{"value" => "100.00"}

      response =
        conn
        |> post(Routes.accounts_path(conn, :deposit, account_id, value))
        |> json_response(:ok)

      assert %{
        "account" => %{"balance" => "100.00", "id" => _id},
        "message" => "Balance updated successfully!"} = response
    end

    test "when have some invalid params, returns a error", %{conn: conn, account_id: account_id} do
      value = %{"value" => "grana!"}

      response =
        conn
        |> post(Routes.accounts_path(conn, :deposit, account_id, value))
        |> json_response(400)

      expected_response = %{"message" => "Invalid deposit value"}

      assert response == expected_response
    end
  end
end
