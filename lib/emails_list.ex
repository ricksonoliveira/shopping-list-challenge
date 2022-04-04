defmodule EmailsList do
  @moduledoc """
  Documentation for `EmailsList`.
  """

  defstruct email: nil

  def distrubute_to_buyers(buyers, sum) do
    buyers_count = Enum.count(buyers)
    value_to_distribute = Float.to_string(sum / buyers_count)

    [value_splitted, rest_splitted] = value_to_distribute |> String.split(".")
    value_integer_to_distribute = String.to_integer(value_splitted)

    rest_value_to_distribute = get_rest_of_value_to_distribute(value_splitted, rest_splitted, buyers_count, sum)
    IO.inspect(rest_value_to_distribute)
    IO.inspect(value_integer_to_distribute)

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
