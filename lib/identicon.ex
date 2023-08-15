defmodule Identicon do
  @moduledoc """
  Documentation for `Identicon`.
  """
  def main(input) do
    input
    |> harsh_input
    |> pick_color
    |> build_grid
    |> filter_odd_squares
  end

  def harsh_input(input) do
    # hash = :crypto.hash(:md5, input)
    # :binary.bin_to_list(hash)

    hex =
      :crypto.hash(:md5, input)
      |> :binary.bin_to_list()

    %Identicon.Image{hex: hex}
  end

  def pick_color(image) do
    %Identicon.Image{hex: hex_list} = image
    [r, g, b | _tail] = hex_list
    %Identicon.Image{image | color: {r, g, b}}
  end

  def build_grid(image) do
    %Identicon.Image{hex: hex} = image

    grid =
      hex
      |> Enum.chunk(3)
      |> Enum.map(&mirror_row/1)
      |> List.flatten()
      |> Enum.with_index()

    %Identicon.Image{image | grid: grid}
  end

  def mirror_row(row) do
    [first, second | _tail] = row

    row ++ [second, first]
  end

  def filter_odd_squares(image) do
    %Identicon.Image{grid: grid} = image
    grid = Enum.filter(grid, fn {code, _index} -> rem(code, 2) == 0 end)

    %Identicon.Image{image | grid: grid}
  end

  # def build_pixelmap(image) do
  #   %Identicon.Image{grid: grid}
  #   pixel_map = Enum.map(grid, fn {index, _} ->
  #     horizontal = rem(index, 5) * 50
  #     vertical = div(index, 5) * 50
  #     {{horizontal, vertical}, {horizontal + 50, vertical + 50}}
  #   end)

  # end
# %Indenticon.Image{image | pixel_map}

end
