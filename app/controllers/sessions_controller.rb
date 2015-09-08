class SessionsController < ApplicationController
  before_action :set_session, only: [:show, :edit, :update, :destroy]
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
      remember user
      redirect_to root_url
      flash[:success] ="Login erfolgreich"
    else
      redirect_to '/login'
      flash[:error] ="Falsche Benutzereingabe/n"
    end
  end

  # PATCH/PUT /sessions/1
  # PATCH/PUT /sessions/1.json
  def update
    respond_to do |format|
      if @session.update(session_params)
        format.html { redirect_to @session, notice: 'Session was successfully updated.' }
        format.json { render :show, status: :ok, location: @session }
      else
        format.html { render :edit }
        format.json { render json: @session.errors, status: :unprocessable_entity }
      end
    end
  end

  def remove
    session[:user_id] = nil
    log_out
    redirect_to root_url
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