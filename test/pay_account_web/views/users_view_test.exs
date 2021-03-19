defmodule PayAccountWeb.UsersViewTest do
  use PayAccountWeb.ConnCase, async: true

  import Phoenix.View

  alias PayAccount.{Account, User}
  alias PayAccountWeb.UsersView

  test "render create.json" do
    params = %{
      name: "Chikko Pankika",
      age: 45,
      password: "123456",
      nickname: "Chikko",
      email: "chikko@gmail.com"
    }

    {:ok, %User{id: user_id, account: %Account{id: account_id}} = user} =
      PayAccount.create_user(params)

    response = render(UsersView, "create.json", user: user)

    expected_response = %{
      message: "User created successfully!",
      user: %{
        account: %{
          balance: Decimal.new("0.00"),
          id: account_id
          },
          id: user_id,
          name: "Chikko Pankika",
          nickname: "Chikko"
          }
        }
    assert expected_response == response
  end

end
