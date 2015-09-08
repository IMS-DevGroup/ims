class SessionsController < ApplicationController
  before_action :set_session, only: [:show, :edit, :update, :destroy]

  skip_before_filter :require_login

  # GET /sessions/new
  def new
    redirect_to root_url if logged_in?
  end


  # POST /sessions
  # POST /sessions.json
  def create
    user = User.authenticate(params[:username], params[:password_unhashed])
    if user
      log_in user
      redirect_to root_url #, :notice => "Logged in!"
    else
      redirect_to '/login' #, :notice => "Falsche Benutzereingabe/n!"
    end
  end


  def remove
    session[:user_id] = nil
    log_out
    redirect_to '/login'
  end


  private
  # Use callbacks to share common setup or constraints between actions.
  def set_session
    @session = Session.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def session_params
    params.require(:session).permit(:session_key)
  end
end