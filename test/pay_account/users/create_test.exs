defmodule PayAccount.Users.CreateTest do
  use PayAccount.DataCase, async: true

  alias PayAccount.User
  alias PayAccount.Users.Create

  describe "call/1" do
    test "when all params is valid, returns an user" do
      params = %{
        name: "Chikko Pankika",
        age: 45,
        password: "123456",
        nickname: "Chikko",
        email: "chikko@gmail.com"
      }

      {:ok, %User{id: user_id}} = Create.call(params)
      user = Repo.get(User, user_id)

      assert %User{name: "Chikko Pankika", age: 45, id: ^user_id} = user
    end

    test "when there are invalid params, returns an error" do
      params = %{
        name: "Chikko Pankika",
        age: 5,
        password: "",
        nickname: "Chikko",
        email: "chikkogmail.com"
      }

      {:error, changeset} = Create.call(params)

      expected_response = %{
        age: ["must be greater than or equal to 18"],
        email: ["has invalid format"],
        password: ["can't be blank"]
      }

      assert errors_on(changeset) == expected_response
    end
  end
end
