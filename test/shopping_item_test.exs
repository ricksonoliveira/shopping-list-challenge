defmodule ShoppingItemTest do
  use ExUnit.Case

  test "Should test structure" do
    shopping_item = %ShoppingItem{quantity: 1, unit_price: 100}
    assert shopping_item.quantity == 1
    assert shopping_item.unit_price == 100
  end

  test "calc_item/2" do
    assert ShoppingItem.calc_item(1, 100) == 100
  end
end
