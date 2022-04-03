defmodule ShoppingList do
  @moduledoc """
  Documentation for `ShoppingList`.
  """

  @doc """
  Start default settings.
  """
  @spec start :: :ok | {:error, atom}
  def start do
    File.write("shopping_list.txt", :erlang.term_to_binary([]))
  end

  @doc """
  Get full shopping_list.

  ## Example

      iex> ShoppingList.create_shopping_list(1, 100)
      iex> ShoppingList.create_shopping_list(1, 500)
      iex> ShoppingList.shopping_list
      [
        %ShoppingItem{quantity: 1, unit_price: 100},
        %ShoppingItem{quantity: 1, unit_price: 500}
      ]
  """
  @spec shopping_list :: any
  def shopping_list, do: read()

  @doc """
  Create shopping list items.

  ## Params

  - quantity: item quantity
  - unit_price: item price

  ## Example

      iex> ShoppingList.start()
      iex> ShoppingList.create_shopping_list(10, 100)
      {:ok, [%ShoppingItem{quantity: 10, unit_price: 100}]}
  """
  @spec create_shopping_list(any, any) :: {:ok, any}
  def create_shopping_list(quantity, unit_price) do
    shopping_list = %ShoppingItem{quantity: quantity, unit_price: unit_price}
    (read() ++ [shopping_list])
      |> :erlang.term_to_binary()
      |> write()

      {:ok, read()}
  end

  defp write(shopping_list) do
    File.write!("shopping_list.txt", shopping_list)
  end


  @doc """
  Read shopping list data file.
  """
  @spec read :: any
  def read() do
    case File.read("shopping_list.txt") do
      {:ok, shopping_list} ->
        shopping_list
        |> :erlang.binary_to_term()
      {:error, :enoent} -> {:error, "Invalid File."}
    end
  end
end
