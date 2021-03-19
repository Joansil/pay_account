# PayAccount
  Backend to banking or finance api to create user, make transfers, deposits and withdraws with authentication
  
To start your Phoenix server:

    * Install dependencies with `mix deps.get`
    * Create and migrate your database with `mix ecto.setup` 
    * Start Phoenix endpoint with `mix phx.server`
    
 - Business Logic
   * To create a new user, you can send the parameters:
   
         curl X POST "http://localhost:4000/users" -H "accept: application/json" -H "content-type: application/json" -d "{ \"age\": \"43\", \"nickname\": \"Test\", \"email\": \"teste@gmail.com\", \"password\": \"123456\", \"name\": \"Testando da Silva\" }"


   *And it will generate the response:

       {"message":"User created successfully!",
         "user":{
         "account":{
           "balance":"0.00",
           "id":"a41db0a9-34a6-42b6-8853-dc27d7e735d1"
        },
         "id":"4aabdcd3-b3e2-457e-b7a9-117e1b197d4a",
         "name":"Testando da Silva",
         "nickname":"Test"
        }
       }

  * If you try create an user without any parameters you get this:

        {
          "message":{
            "age":["must be greater than or equal to 18"],
            "email":["has invalid format"],
            "name":["can't be blank"],
            "password":["should be at least 6 character(s)"]
          }
         }

*And others validations...

   * To make a deposit, you can send the parameters with the (Encode64 Basic Auth code (dXNlcjp1c2Vy) if you're using curl, or if you using Postman or Insomnia or others you can set Basic_Auth with (username: user, password: user).

    curl X POST "http://localhost:4000/accounts/a41db0a9-34a6-42b6-8853-dc27d7e735d1/deposit" -H "accept: application/json" -H "content-type: application/json" -H "Authorization:Basic dXNlcjp1c2Vy" -d "{ \"value\": \"300.00\" }"

   * And then you get this response:

    {
      "message":"Balance updated successfully!",
      "account":{
        "balance":"300.00",
        "id":"a41db0a9-34a6-42b6-8853-dc27d7e735d1"
      }
    }

*The same with the withdraw:

    curl X POST "http://localhost:4000/accounts/a41db0a9-34a6-42b6-8853-dc27d7e735d1/withdrawt" -H "accept: application/json" -H "content-type: application/json" -H "Authorization:Basic dXNlcjp1c2Vy" -d "{ \"value\": \"50.00\" }"

   * And then you get this response:

    {
      "message":"Balance updated successfully!",
      "account":{
        "balance":"250.00",
        "id":"a41db0a9-34a6-42b6-8853-dc27d7e735d1"
      }
    }

   * To make a transfer, you have to had more than 1 user, so you can create another one, and take these account_id to make: from => form_id, to => to_id, just like this:

    curl X POST "http://localhost:4000/accounts/transfer" -H "accept: application/json" -H "content-type: application/json" -H "Authorization:Basic dXNlcjp1c2Vy" -d "{ \"from\": \"3a1c666f-28fd-4c7c-bb56-8908eed178f5\", \"to\": \"a41db0a9-34a6-42b6-8853-dc27d7e735d1\", \"value\": \"50.00\" }"

   * And your response will be:

    {
      "message":"Transfer done successfully",
      "transfer":{
        "from_account":{
            "balance":"200.00",
            "id":"a41db0a9-34a6-42b6-8853-dc27d7e735d1"
        },
        "to_account":{
            "balance":"50.00",
            "id":"3a1c666f-28fd-4c7c-bb56-8908eed178f5"
        }
      }
    }

   * If you try transfer a negative value: 

      curl X POST "http://localhost:4000/accounts/transfer" -H "accept: application/json" -H "content-type: application/json" -H "Authorization:Basic dXNlcjp1c2Vy" -d "{ \"from\": \"3a1c666f-28fd-4c7c-bb56-8908eed178f5\", \"to\": \"a41db0a9-34a6-42b6-8853-dc27d7e735d1\", \"value\": \"250.00\" }"

 *You'll get this:

    {
     "message":{
        "balance":["is invalid"]
     }
    }

*Or a invalid value:

    curl X POST "http://localhost:4000/accounts/transfer" -H "accept: application/json" -H "content-type: application/json" -H "Authorization:Basic dXNlcjp1c2Vy" -d "{ \"from\": \"3a1c666f-28fd-4c7c-bb56-8908eed178f5\", \"to\": \"a41db0a9-34a6-42b6-8853-dc27d7e735d1\", \"value\": \"\" }"

    {"message":"Invalid deposit value"}

   * If you try make a transfer, deposit or withdraw, without an Authorization:

    curl X POST "http://localhost:4000/accounts/3a1c666f-28fd-4c7c-bb56-8908eed178f5/withdraw" -H "accept: application/json" -H "content-type: application/json" -d "{ \"value\": \"50.00\" }"

*You get this:

    Unauthorized


   * Development
     You need to define the environment variable DATABASE_URL with yout database connection string for PostgreSQL:

    $ export DATABASE_URL="postgres://pay_account:pay_account@database:5432/pay_account"
    $ iex -S mix phx.server

   * Tests
    You can run all tests locally using the command:
    
      mix setup         *(Create database)
      mix test --trace  *(Run the tests (its not complete cover...))

   * Contributing
     To contribute you need to:

    * Fork this repo
    * Create a new branch, i.e.: feature/awesome-commit
    * Push your code to your fork
    * Create a pull-request to this repo
    * Await to code review sparkles

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

   * Official website: https://www.phoenixframework.org/
   * Guides: https://hexdocs.pm/phoenix/overview.html
   * Docs: https://hexdocs.pm/phoenix
   * Forum: https://elixirforum.com/c/phoenix-forum
   * Source: https://github.com/phoenixframework/phoenix
