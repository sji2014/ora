defmodule OraWeb.HomeLive do
  use OraWeb, :live_view
  use LiveSvelte.Components

  @topic "public"
  @event_new_message "new_message"

  def render(assigns) do
    ~H"""
    <div>
    <div class="flex flex-col h-screen justify-between">
  <main class="flex flex-col mb-auto h-1/2 bg-transparent">Content</main>
  <.Time socket={@socket} />
</div>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    OraWeb.Endpoint.subscribe(@topic)

    {:ok, assign(socket, messages: [], name: nil)}
  end

  def handle_event("set_name", %{"name" => ""}, socket), do: {:noreply, socket}

  def handle_event("set_name", %{"name" => name}, socket),
    do: {:noreply, assign(socket, name: name)}

  def handle_event("send_message", payload, socket) do
    payload =
      payload
      |> Map.put(:name, socket.assigns.name)
      |> Map.put(:id, System.unique_integer([:positive]))

    OraWeb.Endpoint.broadcast(@topic, @event_new_message, payload)

    {:noreply, socket}
  end

  def handle_info(%{topic: @topic, event: @event_new_message, payload: payload}, socket) do
    {:noreply, assign(socket, messages: socket.assigns.messages ++ [payload])}
  end
end
