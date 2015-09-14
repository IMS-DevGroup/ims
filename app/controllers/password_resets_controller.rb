class PasswordResetsController < ApplicationController
  before_action :get_user,          only: [:edit, :update]
  before_action :valid_user,        only: [:edit, :update]
  before_action :check_expiration,  only: [:edit, :update]

  attr_accessor :password_unhashed
  skip_before_filter :require_login


  def new
  end

  def create
    @user = User.find_by(email: params[:email].downcase) #delete[:password_reset]
    if @user
      @user.create_reset_key

        @user.send_password_reset_email
        flash[:notice] = 'Email zum Zurücksetzen des Passworts gesendet.'
        redirect_to root_url

    else
      flash[:error] = "Gesuchte Emailadresse nicht gefunden."
      render 'new'
    end
  end

  def edit
  end

  def update
    if params[:password_unhashed].empty?
      @user.errors.add(:password_unhashed, 'darf nicht leer sein')
      render 'edit'
    elsif @user.update_attribute(:password_unhashed, params[:password_unhashed])
      @user.encrypt_password #vllt richtig??
      @user.update_attribute(:reset_key, nil) ##damit link nur einmal benutzt werden kann
      log_in @user
      flash[:success] = 'Passwort wurde erfolgreich geändert/gesetzt'
      redirect_to '/starts'
    else
      render 'edit'
    end
  end


  private

  def user_params
    params.require(:user).permit(:passwort_unhashed) #password_unhashed_confirmation
  end

  def get_user
    @user = User.find_by(email: params[:email])
  end

  def valid_user
    unless @user && @user.activated?(params[:id])
    redirect_to root_url
    end
  end

  def check_expiration
    if @user.password_reset_expired?
      flash[:error] = 'Ihr Link zum Zurücksetzen des Passworts ist bereits abgelaufen.'
      redirect_to new_password_reset_url
    end
  end

end
