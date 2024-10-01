defmodule OraWeb.UserRSVPLive do
  use OraWeb, :live_view

  alias Ora.Userland
  alias Ora.Userland.User
  import OraWeb.SVG, only: [ticket: 1]

  def render(assigns) do
    ~H"""
    <div :if={@step == :rsvp} class="max-w-2xl mx-auto relative">
      <div class="mb-6 text-right text-gray-500 font-serif italic">
        <i class="text-sji"> 07/12/2024 </i>
      </div>
      <div class="mb-6 mr-2 -ml-4 font-handwriting text-lg leading-relaxed text-gray-800 whitespace-pre-line">
        dear fellow joseph14n,

        ten years have flown by. while life has taken us down different paths , we all set off on our journeys together from - our Home, SJI.

        we look forward to welcoming you <i class="font-semibold text-sji"> Back Home </i>!

        this will be a wonderful opportunity to reminisce cherished memories, share our journeys, and rekindle our brotherhood. join us for a night filled with joy, cheer, and those same timeless jokes that never fail to make us laugh.
        <b class="text-sji font-semibold">Founder's Hall </b>
        doors open at <b class="text-sji font-semibold"> 6 PM onwards on 7th December</b>
        – no location tags needed, you know the way.
      </div>
      <div class="mt-8 text-right font-handwriting text-lg text-gray-700">
        ora et labora, &nbsp; &nbsp; &nbsp; <br /> the org team
      </div>
      <div class="mt-8 flex flex-wrap justify-center gap-6">
        <.link class="relative focus:outline-none focus:ring-0" phx-click="tix">
          <span class="absolute top-0 left-0 mt-1 ml-1 h-full w-full rounded bg-black"></span>
          <span class="fold-bold relative inline-block h-full w-full rounded border-2 border-black bg-white px-3 py-1 text-base font-bold text-black transition duration-100 hover:bg-brand hover:text-offwhite">
            Buy Ticket
          </span>
        </.link>
      </div>
      <!--
    <div class="flex-none">
     <.header class="text-center text-green-500">
        10 years have passed
        <:subtitle>
        <span>  Since we stood tall in the <i class="font-semibold text-sji"> Founder's Hall </i>&hairsp;  upon Graduation </span>
        <br>
         We are once again stirred to answer St Joseph's Call
        <br>
        <span> to return <b class="text-sji font-semibold"> Back Home </b> </span>
        </:subtitle>
      </.header>

      
      -->
    </div>

    <div :if={@step !== :rsvp} class="justify-center items-center">
      <div :if={!@user}>
        <.header class="text-center text-green-500">
          I'm coming <b class="text-sji font-semibold"> Back Home </b>
          <:subtitle>
            Already RSVP'd for the Reun10n?
            <.link patch={~p"/login"} class="font-semibold text-brand hover:underline">
              Login here
            </.link>
            instead
          </:subtitle>
        </.header>
        <.simple_form
          for={@form}
          id="registration_form"
          phx-submit="save"
          phx-change="validate"
          action={~p"/users/log_in?_action=registered"}
          method="post"
        >
          <.error :if={@check_errors}>
            Oops, something went wrong! Please check the errors below.
          </.error>
          <.inputs_for :let={profile} field={@form[:profile]}>
            <.ticket class="w-max" name={profile[:full_name].value} height="42%" />

            <.input type="text" label="Full Name*" field={profile[:full_name]} required />
            <.input field={@form[:email]} type="email" label="Email*" required />
            <.input
              field={profile[:grad_class]}
              type="select"
              options={[
                "FN401",
                "FN402",
                "FN403",
                "FN404",
                "LE401",
                "LE402",
                "LE403",
                "ML401",
                "ML402",
                "ML403",
                "MN401",
                "MN402",
                "MN403"
              ]}
              label="Graduating Class*"
              required
            />
            <.input field={@form[:tg_handle]} type="text" label="Telegram Handle" />
            <.input type="text" label="Dietary/Comments..." field={profile[:comments]} />
          </.inputs_for>
          <:actions>
            <button
              phx-disable-with="RSVPing..."
              class="relative w-full focus:outline-none focus:ring-0"
            >
              <span class="absolute top-0 left-0 mt-1 ml-1 h-full w-full rounded bg-black"></span>
              <span class="fold-bold relative inline-block h-full w-full rounded border-2 border-black bg-white px-3 py-1 text-base font-bold text-black transition duration-100 hover:bg-brand hover:text-offwhite">
                Yes
              </span>
            </button>
          </:actions>
        </.simple_form>
      </div>

      <div :if={@user} class="flex">
        <.header class="text-center text-green-500">
          Grab your ticket, <b class="text-sji font-semibold"> Back Home </b>
          <:subtitle></:subtitle>
        </.header>
        <div class="flex-none">
          <div :if={@payment}>
            <%= Phoenix.HTML.raw(@payment) %>
          </div>
        </div>
      </div>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    changeset = Userland.change_user_rsvp(%User{})

    socket =
      socket
      |> assign(step: :rsvp, payment: nil, user: nil, check_errors: false)
      |> assign_form(changeset)

    {:ok, socket, temporary_assigns: [form: nil]}
  end

  def handle_event("tix", _, socket) do
    changeset = Userland.change_user_rsvp(%User{})
    {:noreply, assign(socket, :step, :tix) |> assign_form(changeset)}
  end

  def handle_event("save", %{"user" => user_params}, socket) do
    case Userland.rsvp_user(user_params) do
      {:ok, user} ->
        send(socket.parent_pid, {:deliver_link, user})

        # go to payment ping for email

        {:noreply, socket}

      # {:noreply, socket |> assign_form(changeset) |> assign(:user, user) |> assign(:payment, qr )}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, socket |> assign(check_errors: true) |> assign_form(changeset)}
    end
  end

  def handle_event("validate", %{"user" => user_params}, socket) do
    changeset = Userland.change_user_rsvp(%User{}, user_params)
    {:noreply, assign_form(socket, Map.put(changeset, :action, :validate))}
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    form = to_form(changeset, as: "user")

    if changeset.valid? do
      assign(socket, form: form, check_errors: false)
    else
      assign(socket, form: form)
    end
  end
end
