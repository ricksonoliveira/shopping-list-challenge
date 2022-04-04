defmodule EmailsList do
  @moduledoc """
  Documentation for `EmailsList`.
  """

  defstruct email: nil

  @doc """
  Get full emails_list.

  ## Example

  iex> Files.start()
  iex> EmailsList.create_emails_list("rick@mail.com")
  iex> EmailsList.create_emails_list("ana@mail.com")
  iex> EmailsList.emails_list
  [
    %EmailsList{email: "rick@mail.com"},
    %EmailsList{email: "ana@mail.com"}
  ]
  """
  @spec emails_list :: any
  def emails_list, do: Files.read("emails_list")

  @doc """
  Create emails list items.

  ## Params

  - email: email

  ## Example

  iex> Files.start
  iex> EmailsList.create_emails_list("rick@mail.com")
  {:ok, [%EmailsList{email: "rick@mail.com"}]}
  """
  @spec create_emails_list(any) :: {:ok, any}
  def create_emails_list(email) do
    email_list = %EmailsList{email: email}
    (Files.read("emails_list") ++ [email_list])
      |> :erlang.term_to_binary()
      |> Files.write("emails_list")

      {:ok, Files.read("emails_list")}
  end

  @doc """
  Distribute values between buyers.
  """
  def distrubute_to_buyers(buyers, sum) do
    buyers_count = Enum.count(buyers)
    value_to_distribute = calc_and_convert_to_string(buyers_count, sum)

    [value_splitted, rest_splitted] = value_to_distribute |> String.split(".")
    value_integer_to_distribute = String.to_integer(value_splitted)

    rest_value_to_distribute = get_rest_of_value_to_distribute(value_splitted, rest_splitted, buyers_count, sum)

    emails_distributed = %{}
    {emails_list, _} = buyers
      |> Enum.map_reduce(1, fn(buyer, acc) ->
        if String.to_integer(rest_splitted) !== 0 and buyers_count == acc do
          {Map.put(emails_distributed, buyer.email, value_integer_to_distribute + rest_value_to_distribute), acc}
        else
          {Map.put(emails_distributed, buyer.email, value_integer_to_distribute), acc + 1}
        end
      end)

      emails_list
  end

  defp calc_and_convert_to_string(buyers_count, sum) do
    case buyers_count do
      1 ->
       "#{sum}.0"
      _ ->
       Float.to_string(sum / buyers_count)
    end
  end

  defp get_rest_of_value_to_distribute(value_splitted, rest_splitted, buyers_count, sum) do
    case String.to_integer(rest_splitted) do
      0 ->
        0
      _ ->
        total = String.to_integer(value_splitted) * buyers_count
        sum - total
    end
  end
end
