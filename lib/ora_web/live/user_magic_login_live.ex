defmodule OraWeb.UserMagicLoginLive do
  use OraWeb, :live_view
  use LiveSvelte.Components

  alias Ora.Userland
  import OraWeb.SVG, only: [ticket: 1]
  import OraWeb.FilepondComponent, only: [filepond: 1]

  def render(assigns) do
    ~H"""
    <div :if={@step == :login} class="mx-auto max-w-2xl">
      <.header class="text-center flex-none">
        Log in
        <:subtitle>
          Haven't got your ticket yet?
          <.link patch={~p"/invite"} class="font-semibold text-brand hover:underline">
            Grab your ticket
          </.link>
          here
        </:subtitle>
      </.header>

      <.ticket class="mx-auto" width="100%" height="42%" />

      <.simple_form for={@user_form} id="magic_form" phx-submit="save">
        <.input field={@user_form[:email]} type="email" label="Email" required />
        <:actions>
          <.button phx-disable-with="Sending..." class="w-full">
            Receive Login Link &nbsp;  📧
          </.button>
        </:actions>
      </.simple_form>
    </div>

    <div :if={@step == :welcome} class="mx-auto max-w-sm">
      <.header class="text-center">
        On December 7th 6pm
        <:subtitle>
          Tell your fam, tell your boss, tell your wife or the one you are going to wife.
          Mark this
          <i class="font-semibold text-brand hover:underline">
            Saturday Evening
          </i>
          in your gcals, on your walls or your son's SJI diary <br />
          <br /> It's for the bois
        </:subtitle>
      </.header>
      <%!-- <h1>Upload your image here nigga</h1> --%>

      <.Filepond />
      <%!-- <p>wasd</p> --%>
    </div>

    <div :if={@step == :rsvp} class="">
      <%= live_render(@socket, OraWeb.UserRSVPLive, id: "register") %>
    </div>

    <div :if={@step == :auth_waiting} class="mx-auto max-w-sm">
      <.header class="text-center">
        Keep this tab open!
        <:subtitle>
          If you have already RSVP'd for the reunion, you will receive an email with a link at <%= @email %> that will log you in.
        </:subtitle>
      </.header>

      <div class="flex justify-center mt-8">
        <.icon
          :if={@token == nil}
          name="hero-envelope"
          class="h-16 w-16 text-zinc-900 animate-bounce"
        />
        <.icon :if={@token != nil} name="hero-envelope-open" class="h-16 w-16 text-zinc-900" />
      </div>

      <.form
        for={@user_form}
        id="verify_form"
        phx-trigger-action={@trigger_submit}
        action={~p"/users/log_in?_action=magic"}
        method="post"
      >
        <input type="hidden" name={@user_form[:token].name} value={@token} />
      </.form>
    </div>

    <div :if={@step == :verify_success} class="py-48 mx-auto max-w-sm">
      <.header class="text-center">
        Welcome back, <%= @email %>!
        <:subtitle>
          You've been logged in on the browser where you requested this magic link.
        </:subtitle>
      </.header>

      <div class="flex justify-center mt-8">
        <.icon name="hero-envelope-open" class="h-16 w-16 text-zinc-900" />
      </div>
    </div>

    <div :if={@step == :verify_error} class="py-48 mx-auto max-w-sm">
      <.header class="text-center">
        Oops
        <:subtitle>
          Things didn't go as planned, please try again.
        </:subtitle>
      </.header>

      <div class="flex justify-center mt-8">
        <.icon name="hero-x-mark" class="h-16 w-16 text-red-500" />
      </div>
    </div>
    """
  end

  def mount(%{"token" => token}, _session, socket) do
    case Userland.magic_log_in_user(token) do
      {:ok, user} ->
        {:ok,
         redirect(socket, to: ~p"/users/log_in/magic/verify?success=true&email=#{user.email}")}

      :error ->
        {:ok, redirect(socket, to: ~p"/users/log_in/magic/verify?success=false")}
    end
  end

  def mount(%{"success" => "true"} = params, _session, socket) do
    {:ok,
     assign(socket, step: :verify_success, email: params["email"])
     |> assign(:user_form, to_form(%{}, as: :user))
     |> assign(:trigger_submit, false)}
  end

  def mount(%{"success" => "false"}, _session, socket) do
    {:ok,
     assign(socket, step: :verify_error)
     |> assign(:user_form, to_form(%{}, as: :user))
     |> assign(:trigger_submit, false)}
  end

  def mount(_params, %{"step" => step}, socket) do
    {:ok,
     assign(socket, step: step, token: nil)
     |> assign(:user_form, to_form(%{}, as: :user))
     |> assign(:trigger_submit, false)}
  end

  def mount(_params, _session, socket) do
    {:ok,
     assign(socket, step: :login, token: nil)
     |> assign(:user_form, to_form(%{}, as: :user))
     |> assign(:trigger_submit, false)}
  end

  def handle_event("save", %{"user" => %{"email" => user_email}}, socket) do
    case Userland.get_user_by_email(user_email) do
      %Userland.User{} = user ->
        send(self(), {:deliver_link, user})

      _ ->
        Process.send_after(self(), {:deliver_link, user_email}, Enum.random(500..1500))
    end

    {:noreply, socket}
  end

  def handle_info({:deliver_link, %Userland.User{} = user}, socket) do
    token = Userland.deliver_user_magic_log_in(user, &url(~p"/users/log_in/magic/verify/#{&1}"))
    Phoenix.PubSub.subscribe(Ora.PubSub, "magic:#{token.id}")
    {:noreply, socket |> assign(:step, :auth_waiting) |> assign(:email, user.email)}
  end

  def handle_info({:deliver_link, email}, socket) do
    {:noreply, socket |> assign(:step, :auth_waiting) |> assign(:email, email)}
  end

  def handle_info({:magic_log_in, token}, socket) do
    IO.inspect(token, label: "magic")
    Process.send_after(self(), :trigger_submit, :timer.seconds(1))
    {:noreply, assign(socket, :token, token)}
  end

  def handle_info(:trigger_submit, socket) do
    {:noreply, assign(socket, :trigger_submit, true)}
  end
end
