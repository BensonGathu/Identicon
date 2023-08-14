defmodule Identicon do
  @moduledoc """
  Documentation for `Identicon`.
  """
  def main(input) do
    input
    |> harsh_input
  end

  def harsh_input(input) do
    # hash = :crypto.hash(:md5, input)
    # :binary.bin_to_list(hash)

    :crypto.hash(:md5, input)
    |> :binary.bin_to_list()
  end
end
