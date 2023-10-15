defmodule LightsOutGameWeb.Board do
  # `use` calls the live_view function in web module
  use LightsOutGameWeb, :live_view

  @doc """
  Setup the 5x5 grid.
  Also look at this list comprehension!
  """
  def mount(_params, _session, socket) do
    grid = for x <- 0..4, y <- 0..4, into: %{}, do: {{x, y}, false}

    IO.inspect(grid)

    {:ok, assign(socket, grid: grid)}
  end

  def handle_event("toggle", %{"x" => strX, "y" => strY}, socket) do
    grid = socket.assigns.grid

    # parse inputs to integers
    grid_x = String.to_integer(strX)
    grid_y = String.to_integer(strY)

    IO.inspect("x: #{grid_x}, y: #{grid_y}")

    # flip grid button color
    updated_grid = Map.put(grid, {grid_x, grid_y}, !grid[{grid_x, grid_y}])

    IO.inspect("reversed tile: #{!grid[{grid_x, grid_y}]}")
    IO.inspect(updated_grid, label: "updated grid")

    # reassign updated socket
    {:noreply, assign(socket, grid: updated_grid)}
  end
end
