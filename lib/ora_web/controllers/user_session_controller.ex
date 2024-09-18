defmodule OraWeb.UserSessionController do
  use OraWeb, :controller

  alias Ora.Userland
  alias OraWeb.UserAuth

  def create(conn, %{"_action" => "registered"} = params) do
    create(conn, params, "Registered successfully!")
  end

  def create(conn, %{"_action" => "magic", "user" => %{"token" => token}}) do
    case Userland.complete_magic_log_in_user(token) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "Welcome back!")
        |> UserAuth.log_in_user(user)

      :error ->
        conn
        |> put_flash(:error, "Failed to complete magic log-in.")
        |> redirect(to: ~p"/users/log_in/magic")
    end
  end


  def create(conn, %{"_action" => "password_updated"} = params) do
    conn
    |> put_session(:user_return_to, ~p"/users/settings")
    |> create(params, "Password updated successfully!")
  end

  def create(conn, params) do
    create(conn, params, "Welcome back!")
  end

  defp create(conn, %{"user" => %{"email" => email, "password" => password} = user_params}, info) do

    if user = Userland.get_user_by_email_and_password(email, password) do
      conn
      |> put_flash(:info, info)
      |> UserAuth.log_in_user(user, user_params)
    else
      # In order to prevent user enumeration attacks, don't disclose whether the email is registered.
      conn
      |> put_flash(:error, "Invalid email or password")
      |> put_flash(:email, String.slice(email, 0, 160))
      |> redirect(to: ~p"/users/log_in")
    end
  end

  defp create(conn, _, _info) do
      # In order to prevent user enumeration attacks, don't disclose whether the email is registered.
      conn
      |> put_flash(:error, "Invalid email or password")
      |> redirect(to: ~p"/register")
  end

  def delete(conn, _params) do
    conn
    |> put_flash(:info, "Logged out successfully.")
    |> UserAuth.log_out_user()
  end
end
