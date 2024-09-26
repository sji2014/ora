defmodule OraWeb.HomeLive do
  use OraWeb, :live_view
  use LiveSvelte.Components

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
    <.modal :if={@rsvp} id="rsvp" show={@rsvp} patch="/" >
      <%= live_render(@socket, OraWeb.UserMagicLoginLive,
        id: "magic-" <> to_string(@live_action),
        session: %{"step" => @live_action}
      ) %>
    </.modal>

    <.modal :if={@live_action == :upload} id="upload" on_cancel={JS.patch("/")} phx-mounted={@live_action == :upload && show_modal("upload")}>
     <.header class="text-center text-green-500">
        Share Memories of <b class="text-sji font-semibold"> Home </b>
        <:subtitle>
        <span> For those photos we captured in glorious 480 </span>
        <br>
         hiding in our old hardrives, Samsung Galaxy S3s and iPhone4s
        <br>
        </:subtitle>
      </.header>

    <section phx-drop-target={@uploads.mmrs.ref}>

    <form id="upload-form" phx-submit="save" phx-change="validate">
    <.live_file_input upload={@uploads.mmrs} />
    <button type="submit">Upload</button>
    </form>

    <%!-- render each mmrs entry --%>
    <%= for entry <- @uploads.mmrs.entries do %>
    <article class="upload-entry">

    <figure>
    <.live_img_preview entry={entry} />
    <figcaption><%= entry.client_name %></figcaption>
    </figure>

    <%!-- entry.progress will update automatically for in-flight entries --%>
    <progress value={entry.progress} max="100"> <%= entry.progress %>% </progress>

    <%!-- a regular click event whose handler will invoke Phoenix.LiveView.cancel_upload/3 --%>
    <button type="button" phx-click="cancel-upload" phx-value-ref={entry.ref} aria-label="cancel">&times;</button>

    <%!-- Phoenix.Component.upload_errors/2 returns a list of error atoms --%>
    <%= for err <- upload_errors(@uploads.mmrs, entry) do %>
    <p class="alert alert-danger"><%= error_to_string(err) %></p>
    <% end %>

    </article>
    <% end %>

    <%!-- Phoenix.Component.upload_errors/1 returns a list of error atoms --%>
    <%= for err <- upload_errors(@uploads.mmrs) do %>
    <p class="alert alert-danger"><%= error_to_string(err) %></p>
    <% end %>

    </section>

      <:confirm type="submit" form="song-form">Save</:confirm>
      <:cancel>Cancel</:cancel>
    </.modal>


    <body class="bg-[linear-gradient(90deg,_#faf9f6,_#c2fff1)] bg-[length:400%_400%] animate-gradient">
      <div class="flex flex-col justify-between  h-screen overflow-hidden">
        <div :if={!@month} class="animate-fade w-1/2 h-1/2 max-w-md mx-auto">
          <svg
            viewBox="0 0 100 100"
            class="duration-5000 animate-pulse ease-in-out  hover:animate-none"
            aria-hidden="true"
          >
            <.link
              patch={~p"/mmrs"}
              class="text-sm leading-6 text-zinc-900 font-semibold hover:text-brand"
            >
              <image xlink:href="/images/logo.svg" width="100" height="120" />
            </.link>
          </svg>
          <.Countdown
            class="pt-8"
            id="countdown"
            dateTime={DateTime.new!(~D[2024-12-07], ~T[10:00:00]) |> DateTime.to_unix()}
          />
        </div>
        <main :if={@month} class="flex text-white text-center flex-col mb-auto h-2/3">
          <div class="flex items-center flex-col  h-full overflow-y-scroll" style="max-height: 90vh;">
            <div class="animate-marquee hover:[animation-play-state:paused]">
              <img
                :for={p <- @photos[@month]}
                src={p}
                class="relative w-48 py-3 h-48 transition-transform duration-700 ease-in-out hover:scale-110 hover:filter-none filter grayscale brightness-50"
                tabindex="0"
              />
            </div>
          </div>
        </main>

        <span :if={@time} class="text-xl text-center text-brand pt-6 ">
          <%= @time.month %>
        </span>

        <.Time id="timeline" timelineHeight="200" socket={@socket} />
      </div>
      <div class="absolute bottom-0 w-full ">
        <nav id="year" class="flex justify-between p-2 lg:px-20 bg-transparent border">
          <a
            :for={y <- 2011..2014}
            class={[
              (y == @time.year && "text-sji drop-shadow-md") ||
                "text-gray-400 hover:text-brand text-xs",
              "nav-item relative flex flex-col items-center justify-center  hover:animate-flicker transition duration-300"
            ]}
          >
            <span class="font-semibold cursor-pointer" phx-click="pushYear" phx-value-year={y}>
              <%= y %>
            </span>
          </a>
        </nav>
      </div>
      <div>
      </div>
    </body>
    """
  end

  # way to upload images get exif store and sort and query db memory model. image jpeg tiff only filter out lack of exif
  #
  # determine length based on count
  # # BUY YOUR TICKET ACTION (my ticket status)
  # UPLOAD MEMORY ACTION (memory select date )
  # Contact Us : Email sji, Telegram suhas (tooltip)
  #
  # reminder email
  # fanout emails for QR Code of ticket with payment processing (template needed )

  def mount(_params, _session, socket) do

    {:ok,
     assign(socket, time: %{month: nil, order: nil, year: nil}, month: nil, photos: gen_map(), rsvp: false, memory: false)
     |> assign(:uploaded_files, [])
     |> allow_upload(:mmrs, accept: ~w(.jpg .jpeg), max_entries: 2)
    }

  end

  def handle_params(_params, _uri, socket) do
    {:noreply, action_handler(socket)}
  end

  def handle_event("pushMonth", %{"month" => month}, socket),
    do: {:noreply, assign(socket, month: month, time: convert(month))}

  def handle_event("pushYear", %{"year" => year}, %{assigns: %{time: time}} = socket) do
    {:noreply,
     socket
     # |> assign(time: %{time | year: String.to_integer(year)})
     |> push_event("pullMonth", %{
       index: (time.order || 1) - 1 + (String.to_integer(year) - 2011) * 12
     })}
  end

  def handle_event("validate", _params, socket) do
    {:noreply, socket}
  end

  def handle_event("cancel-upload", %{"ref" => ref}, socket) do
    {:noreply, cancel_upload(socket, :mmrs, ref)}
  end

 def handle_event("save", _params, socket) do
    uploaded_files =
      consume_uploaded_entries(socket, :mmrs, fn %{path: path}, _entry ->
        dest = Path.join([:code.priv_dir(:ora), "static", "uploads", Path.basename(path)])
        # You will need to create `priv/static/uploads` for `File.cp!/2` to work.
        File.cp!(path, dest)
        {:ok, path}
      end)

    {:noreply, update(socket, :uploaded_files, &(&1 ++ uploaded_files))}
  end


  defp action_handler(%{assigns: %{live_action: action}} = socket)
       when action in [:rsvp, :login] do
    socket
    |> assign(:rsvp, true)
    |> assign(:memory, false)
  end

  defp action_handler(%{assigns: %{live_action: :upload}} = socket) do
    socket
    |> assign(:memory, true)
    |> assign(:rsvp, false)
  end

  defp action_handler(%{assigns: %{live_action: _act}} = socket) do
    socket
    |> assign(:rsvp, false)
    |> assign(:memory, false)
  end

  def gen_map do
    # Create a map with keys from 1 to random_length
    map =
      Enum.reduce(1..48, %{}, fn key, acc ->
        # Generate a random list of integers (1 to 100) with a random length (1 to 10)
        random_list_length = :rand.uniform(10)
        random_list = for _ <- 1..random_list_length, do: Enum.random(@img)

        # Add the key and list to the accumulator
        Map.put(acc, key, random_list)
      end)

    map
  end

  def convert(index) when index >= 1 and index <= 48 do
    month = rem(index, 12)

    months = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December"
    ]

    %{
      month: Enum.at(months, month - 1),
      order: month,
      year: Enum.at([2011, 2012, 2013, 2014], floor((index - 1) / 12))
    }
  end

  def convert(_) do
    %{month: nil, order: nil, year: nil}
  end


  defp error_to_string(:too_large), do: "damn your camera back then bigger than 5megapixel try compress to upload"
  defp error_to_string(:too_many_files), do: "uploading too many mmrs at once"
  defp error_to_string(:not_accepted), do: "our stupid ai only understands jpeg/jpg"
end
