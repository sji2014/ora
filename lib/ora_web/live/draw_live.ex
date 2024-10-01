defmodule OraWeb.DrawLive do
  use OraWeb, :live_view
  use LiveSvelte.Components

  def mount(_, _, socket) do
    socket = assign(socket, pad_id: Ecto.UUID.generate())

    if connected?(socket) do
      Phoenix.PubSub.subscribe(Ora.PubSub, topic(socket))
      Phoenix.PubSub.subscribe(Ora.PubSub, "scribble_pads")
    end

    {:ok, assign(socket, all_pads: [])}
  end

  defp topic(socket), do: "scribble_lines:" <> socket.assigns.pad_id

  def render(assigns) do
    ~H"""
    <div class="flex">
      <.Draw class="flex1" socket={@socket} allPads={@all_pads} currentPadId={@pad_id} />
      <.svelte
        class="flex1"
        name="Draw"
        socket={@socket}
        props={%{allPads: @all_pads, currentPadId: @pad_id}}
      />
    </div>
    """
  end

  def handle_event("line_drawn", %{"color" => color, "path" => path}, socket) do
    Phoenix.PubSub.broadcast_from(
      Ora.PubSub,
      self(),
      topic(socket),
      {:new_line, %{color: color, path: path}}
    )

    {:noreply, socket}
  end

  def handle_event("clear_drawing", _, socket) do
    Phoenix.PubSub.broadcast_from(Ora.PubSub, self(), topic(socket), :clear_drawing)

    {:noreply, socket}
  end

  def handle_info({:new_line, line}, socket) do
    {:noreply, push_event(socket, "new_line", line)}
  end

  def handle_info(:clear_drawing, socket) do
    socket =
      socket
      |> push_event("clear_drawing", %{})

    {:noreply, socket}
  end

  def handle_info({:new_pad, pad_id}, socket) do
    socket = assign(socket, all_pads: Enum.sort([pad_id | socket.assigns.all_pads]))

    {:noreply, socket}
  end
end
