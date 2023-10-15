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
end
