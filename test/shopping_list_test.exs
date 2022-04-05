defmodule ShoppingListTest do
  use ExUnit.Case
  doctest ShoppingList

  setup do
    Files.start()

    on_exit(fn ->
      File.rm("shopping_list.txt")
      File.rm("emails_list.txt")
    end)
  end

  test "shopping list/0" do
    ShoppingList.create_shopping_list(10, 100)
    assert ShoppingList.shopping_list() |> Enum.count() == 1
  end

  test "get_shopping_list_distributed/0 with one list" do
    ShoppingList.create_shopping_list(10, 100)
    EmailsList.create_emails_list("rick@mail.com")

    assert ShoppingList.get_shopping_list_distributed() ==
             {:ok, [%{"rick@mail.com" => 1000}]}
  end

  test "get_shopping_list_distributed/0 with omore than one list" do
    ShoppingList.create_shopping_list(10, 100)
    ShoppingList.create_shopping_list(1, 100)
    EmailsList.create_emails_list("rick@mail.com")
    EmailsList.create_emails_list("ana@mail.com")

    assert ShoppingList.get_shopping_list_distributed() ==
             {:ok,
              [
                %{"rick@mail.com" => 550},
                %{"ana@mail.com" => 550}
              ]}
  end

  test "get_shopping_list_distributed/0 will return error when some list is empty" do
    EmailsList.create_emails_list("rick@mail.com")
    EmailsList.create_emails_list("ana@mail.com")

    assert ShoppingList.get_shopping_list_distributed() ==
             {:error, "Shopping list and Email list should have at least one info!"}
  end
end
