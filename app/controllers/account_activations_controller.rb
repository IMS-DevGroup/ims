class AccountActivationsController < ApplicationController
=begin
  def edit
    user = User.find_by(email: params[:email])
    if user && !user.validated? && user.authenticated?(params[:id])
      user.activate # muss noch anders gemacht werden
      log_in user
      flash[:success] = "Account aktiviert!"
      redirect_to 'starts#index'
    else
      flash[:error] = 'Fehlerhafter Aktivierungslink'
      redirect_to root_url
    end
  end
=end
end
