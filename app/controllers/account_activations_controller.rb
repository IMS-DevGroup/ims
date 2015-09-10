class AccountActivationsController < ApplicationController
  def edit
    user = User.find_by(email: params[:email])
    if user && user.validated == false && user.activated?(:activation, :params[:id])
      user.activate
      log_in user
      flash[:succsess] = "Account aktiviert!"
      redirect_to 'starts#index'
    else
      flash[:error] = "Ungültiger Aktivierungslink!"
      redirect_to root_url
    end
  end
end
