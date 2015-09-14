class SessionsController < ApplicationController
  before_action :set_session, only: [:show, :edit, :update, :destroy]

  skip_before_filter :require_login
  # GET /sessions/new
  def new
    redirect_to '/starts' if logged_in?
  end

  # POST /sessions
  # POST /sessions.json
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

  def remove
      log_out if logged_in?
      redirect_to root_url
  end
end