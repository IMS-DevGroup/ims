class SessionsController < ApplicationController
  before_action :set_session, only: [:show, :edit, :update, :destroy]

  skip_before_filter :require_login # can be accessed without being logged in
  # GET /sessions/new
  def new
    redirect_to '/starts' if logged_in?
  end

  # POST /sessions
  # POST /sessions.json
  # Logs in and sets remember me if whished, sets session - all if the login is successfull
  def create
    user = User.authenticate(params[:username], params[:password_unhashed])
    if user
        log_in user
        params[:remember_me] == '1' ? remember(user) : forget(user)
        redirect_to "/starts"
        flash[:success] = (I18n.t "own.success.user_login").to_s
    else
        redirect_to "/login"
      flash[:error] = (I18n.t "own.errors.user_login").to_s
    end
  end

  # logs out the current user.
  def remove
      log_out if logged_in?
      redirect_to root_url
  end
end