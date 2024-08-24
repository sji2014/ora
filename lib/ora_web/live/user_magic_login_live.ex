defmodule OraWeb.UserMagicLoginLive do
  use OraWeb, :live_view

  alias Ora.Userland

  def render(assigns) do
    ~H"""
    <div :if={@step == :auth_ready} class="mx-auto max-w-sm">
      <.header class="text-center">
        Log in with magic link
        <:subtitle>
          Enter your email to receive a magic log-in link.
        </:subtitle>
      </.header>

      <.simple_form for={@user_form} id="magic_form" phx-submit="save">
        <.input field={@user_form[:email]} type="email" label="Email" required />
        <:actions>
          <.button phx-disable-with="Submitting..." class="w-full">
            Send a link
          </.button>
        </:actions>
      </.simple_form>
    </div>

    <div :if={@step == :auth_waiting} class="mx-auto max-w-sm">
      <.header class="text-center">
        Waiting...
        <:subtitle>
          If you have a user account with us, you will receive an email with a link to log in.
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

    <div :if={@step == :verify_success} class="mx-auto max-w-sm">
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

    <div :if={@step == :verify_error} class="mx-auto max-w-sm">
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
    {:ok, assign(socket, step: :verify_success, email: params["email"])}
  end

  def mount(%{"success" => "false"}, _session, socket) do
    {:ok, assign(socket, step: :verify_error)}
  end

  def mount(_params, _session, socket) do
    {:ok, assign(socket, step: :auth_ready, token: nil)}
  end

  def handle_params(_params, _uri, socket) do
    {:noreply,
     socket
     |> assign(:user_form, to_form(%{}, as: :user))
     |> assign(:trigger_submit, false)}
  end

  def handle_event("save", %{"user" => user_params}, socket) do
    save_user(socket, socket.assigns.live_action, user_params)
  end

  def save_user(socket, :log_in, %{"email" => user_email}) do
    case Userland.get_user_by_email(user_email) do
      %Userland.User{} = u ->
        token = Userland.deliver_user_magic_log_in(u, &url(~p"/users/log_in/magic/verify/#{&1}"))
        Phoenix.PubSub.subscribe(Ora.PubSub, "magic:#{token.id}")
      _ ->
        Process.sleep(Enum.random(500..1500))
    end

    {:noreply, socket
     |> assign(:step, :auth_waiting)
     |> assign(:email, user_email)}
  end

  def handle_info({:magic_log_in, token}, socket) do
    Process.send_after(self(), :trigger_submit, :timer.seconds(1))
    {:noreply, assign(socket, :token, token)}
  end

  def handle_info(:trigger_submit, socket) do
    {:noreply, assign(socket, :trigger_submit, true)}
  end
end
