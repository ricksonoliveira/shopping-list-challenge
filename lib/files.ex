defmodule Files do
  @moduledoc """
  Documentation for `Files`.
  """

  @doc """
  Start default settings.

  ## Example

      iex> Files.start
      :ok
  """
  @spec start :: :ok | {:error, atom}
  def start do
    File.write("shopping_list.txt", :erlang.term_to_binary([]))
    File.write("emails_list.txt", :erlang.term_to_binary([]))
  end

  @doc """
  Read files.

  ## Params

  - filename: filename

  ## Example

      iex> Files.start
      iex> Files.read("shopping_list")
      []

      iex> Files.start
      iex> Files.read("")
      {:error, "Invalid File."}
  """
  @spec read(any) :: any
  def read(filename) do
    case File.read("#{filename}.txt") do
      {:ok, file_data} ->
        file_data
        |> :erlang.binary_to_term()

      {:error, :enoent} ->
        {:error, "Invalid File."}
    end
  end

  @doc """
  Write files.

  ## Params

    - data: data
    - filename

  ## Example

      iex> Files.start
      iex> Files.write([1, 2, 3], "test")
      :ok
  """
  @spec write(
          binary
          | maybe_improper_list(
              binary | maybe_improper_list(any, binary | []) | byte,
              binary | []
            ),
          any
        ) :: :ok
  def write(data, filename) do
    File.write!("#{filename}.txt", data)
  end
end
