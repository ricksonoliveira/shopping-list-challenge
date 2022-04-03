defmodule ShoppingItem do
  @moduledoc """
  Documentation for `ShoppingItem`.
  """

  defstruct quantity: nil, unit_price: nil

  @doc """
  Multiplies quantity times unit_price
  """
  @spec calc_item(number, number) :: number
  def calc_item(quantity, unit_price), do: quantity * unit_price
end
