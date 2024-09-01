defmodule OraWeb.HomeLive do
  use OraWeb, :live_view
  use LiveSvelte.Components

  @topic "public"
  @event_new_message "new_message"

  @img [
    "https://res.cloudinary.com/dyvotpxft/image/upload/v1723483677/6_cyknpp.png",
    "https://res.cloudinary.com/dyvotpxft/image/upload/v1723483676/3_mxnxwe.png",
    "https://res.cloudinary.com/dyvotpxft/image/upload/v1723483677/7_pse522.png",
    "https://res.cloudinary.com/dyvotpxft/image/upload/v1723484005/21_wbsty7.png",
    "https://res.cloudinary.com/dyvotpxft/image/upload/v1723483677/5_tyr6bh.png",
    "https://res.cloudinary.com/dyvotpxft/image/upload/v1723483676/2_zja2bq.png",
    "https://res.cloudinary.com/dyvotpxft/image/upload/v1723483677/4_zwjtxg.png",
    "https://res.cloudinary.com/dyvotpxft/image/upload/v1723483676/1_zlqnwl.jpg",
    "https://res.cloudinary.com/dyvotpxft/image/upload/v1723483677/8_ucihr5.png",
    "https://res.cloudinary.com/dyvotpxft/image/upload/v1723483676/16_epnmqm.png",
    "https://res.cloudinary.com/dyvotpxft/image/upload/v1723483676/15_voqq0c.png",
    "https://res.cloudinary.com/dyvotpxft/image/upload/v1723484270/Screenshot_23_8_nbzwdm.png"
]

  def render(assigns) do
    ~H"""
    <div>
    <div class="flex bg-[linear-gradient(45deg,_#faf9f6,_#bae6de)] bg-[length:500%_500%] animate-gradient flex-col h-screen justify-between overflow-hidden">
  <main class="flex text-white text-center flex-col mb-auto h-4/5">
  <div :if={@month} class="flex items-center flex-col  h-full overflow-y-scroll" style="max-height: 90vh;">
      <div class="animate-marquee hover:animate-none">
      <img :for={p <- @photos[@month]} src={p} class="relative w-48 py-3 h-48 transition-transform duration-1000 ease-in-out hover:scale-110 hover:filter-none filter grayscale brightness-50" tabindex="0"/>
      </div>
  </div>
  <br>
  <span :if={@time} class="text-2xl text-brand pt-6 ">
  <%= @time.month %>
  </span>
  </main>
  <.Time socket={@socket} />
  </div>
    </div>
    """
  end

  # auto scroll when hover

  def mount(_params, _session, socket) do
    OraWeb.Endpoint.subscribe(@topic)

    {:ok, assign(socket, time: %{month: nil, year: nil}, month: nil, photos: gen_map())}
  end

  def handle_event("pushMonth", %{"month" => month}, socket), do: {:noreply, assign(socket, month: month, time: convert(month))}

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

  def gen_map do
    # Create a map with keys from 1 to random_length
    map = Enum.reduce(1..48, %{}, fn key, acc ->
      # Generate a random list of integers (1 to 100) with a random length (1 to 10)
      random_list_length = :rand.uniform(10)
      random_list = for _ <- 1..random_list_length, do: Enum.random(@img)

      # Add the key and list to the accumulator
      Map.put(acc, key, random_list)
    end)

    map
  end

  def convert(index) when index >= 1 and index <= 48 do
    month= rem(index, 4)
    months = [
      "January", "February", "March", "April", "May", "June",
      "July", "August", "September", "October", "November", "December"]

    %{month: Enum.at(months, month - 1),
      year: Enum.at([2011, 2012, 2013, 2014], floor(index/4)-1)}
  end
end
