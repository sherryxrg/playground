defmodule LightsOutGameWeb.Board do
  # `use` calls the live_view function in web module
  use LightsOutGameWeb, :live_view

  @type coordinates :: {integer(), integer()}
  @type tile :: {coordinates(), Boolean.t()}

  @doc """
  Setup the 5x5 grid.
  Also look at this list comprehension!
  """
  def mount(_params, _session, socket) do
    grid = for x <- 0..4, y <- 0..4, into: %{}, do: {{x, y}, false}

    {:ok, assign(socket, grid: grid)}
  end

  def handle_event("toggle", %{"x" => strX, "y" => strY}, socket) do
    grid = socket.assigns.grid

    # parse inputs to integers
    grid_x = String.to_integer(strX)
    grid_y = String.to_integer(strY)

    updated_tiles =
      {grid_x, grid_y}
      |> with_adjacent_tiles()
      |> Enum.map(fn coords -> flip_tile(coords, grid) end)
      |> Enum.into(%{})

    updated_grid = Map.merge(grid, updated_tiles)

    {:noreply, assign(socket, grid: updated_grid)}
  end

  @spec with_adjacent_tiles(coordinates()) :: list(coordinates())
  def with_adjacent_tiles({x, y}) do
    prevX = Kernel.max(0, x - 1)
    nextX = Kernel.min(4, x + 1)

    prevY = Kernel.max(0, y - 1)
    nextY = Kernel.min(4, y + 1)

    [{x, y}, {x, prevY}, {x, nextY}, {prevX, y}, {nextX, y}]
  end

  @spec flip_tile(coordinates(), map()) :: tile()
  def flip_tile({x, y}, grid) do
    {{x, y}, !grid[{x, y}]}
  end
end
