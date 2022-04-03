defmodule EmailsList do
  @moduledoc """
  Documentation for `EmailsList`.
  """

  defstruct email: nil

  def distrubute_to_buyers(buyers, sum) do
    value_to_distribute = sum / Enum.count(buyers)

    if is_float(value_to_distribute) do
      total = value_to_distribute * sum
      rest = sum - total

      [_, value_splitted] =
        value_to_distribute
          |> Float.to_string()
          |> String.split(".")
      ceil_length = String.length(value_splitted)
      ^value_to_distribute = Float.ceil(value_to_distribute, ceil_length)
    end

    buyers
      |> Enum.map(fn buyer ->
        ["#{buyer.email}": value_to_distribute]
      end)
  end
end
