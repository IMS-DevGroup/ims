class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.authenticate(params[:username], params[:password]) #don't forget method authenticate
  ##succsess? fail?

  end

  def destroy
    session[
    #UserID
    ] = nil
    redirect_to root_url , :notice => "Logged out!"
  end



end
