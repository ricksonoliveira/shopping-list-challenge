defmodule ShoppingList do
  @moduledoc """
  Documentation for `ShoppingList`.
  """

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
  def shopping_list, do: Files.read("shopping_list")

  @doc """
  Create shopping list items.

  ## Params

  - quantity: item quantity
  - unit_price: item price

  ## Example

      iex> Files.start
      iex> ShoppingList.create_shopping_list(10, 100)
      {:ok, [%ShoppingItem{quantity: 10, unit_price: 100}]}

      iex> Files.start
      iex> ShoppingList.create_shopping_list(1.0, 100)
      {:error, "Quantity and Unit Price must be integers!"}
  """
  @spec create_shopping_list(any, any) :: {:ok, any}
  def create_shopping_list(quantity, unit_price) do
    case is_quantity_and_unit_price_valid?(quantity, unit_price) do
      {:ok, false} ->
        shopping_list = %ShoppingItem{quantity: quantity, unit_price: unit_price}
        (Files.read("shopping_list") ++ [shopping_list])
          |> :erlang.term_to_binary()
          |> Files.write("shopping_list")

        {:ok, Files.read("shopping_list")}
      {:error, message} ->
        {:error, message}
    end
  end

  defp is_quantity_and_unit_price_valid?(quantity, unit_price) do
    case !is_integer(quantity) or !is_integer(unit_price) do
      true ->
        {:error, "Quantity and Unit Price must be integers!"}
      false ->
        {:ok, false}
    end
  end

  @doc """
  Returns the list of emails with values distributed.
  """
  @spec get_shopping_list_distributed :: {:error, <<_::472>>} | {:ok, list}
  def get_shopping_list_distributed do
    shopping_list = shopping_list()
    emails_list = EmailsList.emails_list()

    case is_shopping_or_email_list_empty?(shopping_list, emails_list) do
      {:error, message} ->
        {:error, message}
      {:ok, false} ->
        {:ok, calc(shopping_list, emails_list)}
    end
  end

  defp is_shopping_or_email_list_empty?(shopping_list, emails_list) do
    case Enum.empty?(shopping_list) or Enum.empty?(emails_list) do
      true ->
        {:error, "Shopping list and Email list should have at least one info!"}
      false ->
        {:ok, false}
    end
  end

  @doc """
  Calculates the shopping list and distributes values to the buyers.
  """
  @spec calc(any, any) :: list
  def calc(shopping_list, emails_list) do
    shopping_list_sum =
      shopping_list
        |> Enum.map(&(ShoppingItem.calc_item(&1.quantity, &1.unit_price)))
        |> Enum.sum()

    emails_list
      |> EmailsList.distrubute_to_buyers(shopping_list_sum)
  end
end
