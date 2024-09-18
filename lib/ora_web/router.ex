defmodule OraWeb.Router do
  use OraWeb, :router

  import OraWeb.UserAuth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {OraWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_user
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", OraWeb do
    pipe_through :browser
    live "/talk", TalkLive, :home
    live "/draw", DrawLive, :home
    # get "/", PageController, :home
    # get "/counter", CounterController, :home
  end

  # Other scopes may use custom stacks.
  # scope "/api", OraWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:ora, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: OraWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end

  ## Authentication routes

  scope "/", OraWeb do
    pipe_through [:browser, :redirect_if_user_is_authenticated]

    live_session :redirect_if_user_is_authenticated,
      on_mount: [{OraWeb.UserAuth, :redirect_if_user_is_authenticated}] do
      live "/login", HomeLive, :login
      live "/invite", HomeLive, :rsvp
      live "/users/register", UserRegistrationLive, :new
      live "/users/log_in", UserLoginLive, :new
      live "/users/reset_password", UserForgotPasswordLive, :new
      live "/users/reset_password/:token", UserResetPasswordLive, :edit
      live "/users/log_in/magic", UserMagicLoginLive, :log_in
      live "/users/log_in/magic/verify/:token", UserMagicLoginLive, :verify
    end

    post "/users/log_in", UserSessionController, :create
  end

  scope "/", OraWeb do
    pipe_through [:browser, :require_authenticated_user]

    live_session :require_authenticated_user,
      on_mount: [{OraWeb.UserAuth, :ensure_authenticated}] do
      live "/users/settings", UserSettingsLive, :edit
      live "/users/settings/confirm_email/:token", UserSettingsLive, :confirm_email
    end
  end

  scope "/", OraWeb do
    pipe_through [:browser]

    delete "/users/log_out", UserSessionController, :delete

    live_session :current_user,
      on_mount: [{OraWeb.UserAuth, :mount_current_user}] do
      live "/", HomeLive, :home
      live "/welcome", HomeLive, :welcome
      live "/users/confirm/:token", UserConfirmationLive, :edit
      live "/users/confirm", UserConfirmationInstructionsLive, :new
      live "/users/log_in/magic/verify", UserMagicLoginLive, :verify
    end
  end
end
