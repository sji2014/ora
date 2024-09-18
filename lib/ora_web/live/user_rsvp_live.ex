defmodule OraWeb.UserRSVPLive do
  use OraWeb, :live_view

  alias Ora.Userland
  alias Ora.Userland.User

  def render(assigns) do
    ~H"""
    <div :if={@step == :rsvp} class="mx-auto max-w-sm">
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
        <.input type="text" label="Full Name" field={profile[:full_name]} required/>
        <.input field={profile[:grad_class]} type="select" options={["FN401", "FN402", "FN403","FN404", "LE401", "LE402", "LE403", "ML401", "ML402", "ML403", "MN401", "MN402", "MN403"]}label="Graduating Class" required />
        </.inputs_for>
        <.input field={@form[:email]} type="email" label="Email" required />

        <:actions>
          <.button phx-disable-with="RSVPing..." class="w-full hover:bg-sji ">RSVP 🥳</.button>
        </:actions>
      </.simple_form>
    </div>

    <div :if={@step != :rsvp} class="mx-auto max-w-sm">
     <.header class="text-center text-green-500">
        10 years have passed
        <:subtitle>
        <span>  Since we stood tall in the <i class="font-semibold text-sji"> Founder's Hall </i>&hairsp;  upon Graduation </span>
        <br>
         We are once again stirred to answer St Joseph's Call
        <br>
        <span> This time to return <b class="text-sji font-semibold"> Back Home </b> </span>
        </:subtitle>
      </.header>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    changeset = Userland.change_user_rsvp(%User{})
    socket =
      socket
      |> assign(step: :rsvp, check_errors: false)
      |> assign_form(changeset)

    {:ok, socket, temporary_assigns: [form: nil]}
  end

  def handle_event("save", %{"user" => user_params}, socket) do
    case Userland.rsvp_user(user_params) do
      {:ok, user} ->

        send(socket.parent_pid, {:deliver_link, user})

        changeset = Userland.change_user_rsvp(user)
        {:noreply, socket |> assign_form(changeset) |> assign(:step, :welcome)}

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
