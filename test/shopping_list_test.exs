defmodule ShoppingListTest do
  use ExUnit.Case
  doctest ShoppingList

  setup do
    File.write("shopping_list.txt", :erlang.term_to_binary([]))

    on_exit(fn ->
      File.rm("shopping_list.txt")
    end)
  end

  test "shopping list/0" do
    ShoppingList.create_shopping_list(10, 100)
    assert ShoppingList.shopping_list() |> Enum.count() == 1
  end

  test "read invalid file" do
    File.rm("shopping_list.txt")
    assert ShoppingList.read() == {:error, "Invalid File."}
  end
end
