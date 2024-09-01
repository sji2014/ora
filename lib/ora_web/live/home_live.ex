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
    <div class="flex bg-black flex-col h-screen justify-between overflow-hidden">
  <main class="flex text-white text-center flex-col mb-auto h-3/4">
  <%= @year %>
  <div :if={@month} class="flex items-center flex-col gap-2 h-full overflow-y-scroll" style="max-height: 90vh;">
      <img :for={p <- @photos[@month]} src={p} class="relative w-48 h-48 bg-gray-800 bg-cover bg-center transition-transform duration-1000 ease-in-out hover:scale-110 hover:filter-none filter grayscale brightness-50" tabindex="0"/>
  </div>
  </main>
  <.Time socket={@socket} />
  </div>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    OraWeb.Endpoint.subscribe(@topic)

    {:ok, assign(socket, year: nil, month: nil, photos: gen_map())}
  end

  def handle_event("pushMonth", %{"month" => month}, socket), do: {:noreply, assign(socket, month: month, year: convert(month))}

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
    months = [
      "January 2011", "February 2011", "March 2011", "April 2011", "May 2011", "June 2011",
      "July 2011", "August 2011", "September 2011", "October 2011", "November 2011", "December 2011",
      "January 2012", "February 2012", "March 2012", "April 2012", "May 2012", "June 2012",
      "July 2012", "August 2012", "September 2012", "October 2012", "November 2012", "December 2012",
      "January 2013", "February 2013", "March 2013", "April 2013", "May 2013", "June 2013",
      "July 2013", "August 2013", "September 2013", "October 2013", "November 2013", "December 2013",
      "January 2014", "February 2014", "March 2014", "April 2014", "May 2014", "June 2014",
      "July 2014", "August 2014", "September 2014", "October 2014", "November 2014", "December 2014"
    ]

    Enum.at(months, index - 1)
  end
end
