class PasswordResetsController < ApplicationController
  before_action :get_user,          only: [:edit, :update]
  before_action :valid_user,        only: [:edit, :update]
  before_action :check_expiration,  only: [:edit, :update]

  attr_accessor :password_unhashed
  skip_before_filter :require_login


  def new
  end
  # Searches for the given user by email, if found, a reset_key is created and send to the email
  def create
    @user = User.find_by(email: params[:email].downcase)
    if @user
      @user.create_reset_key

        @user.send_password_reset_email
        flash[:notice] = (I18n.t "own.success.password_reset_email_sent").to_s
        redirect_to root_url

    else
      flash[:error] = (I18n.t "own.errors.password_reset_email_not_found").to_s
      render 'new'
    end
  end

  def edit
  end
  # Sets the new password if all entries were correct and resets the reset_key when used
  def update
    if params[:password_unhashed].empty?
#      @user.errors.add(:password_unhashed, 'darf nicht leer sein')
      flash[:error] = (I18n.t "own.errors.empty_field").to_s
      render 'edit'
    elsif params[:password_unhashed_confirmation] != params[:password_unhashed]
      flash[:error] = (I18n.t "own.errors.password_confirmation").to_s
      render 'edit'

    elsif @user.update_attribute(:password_unhashed, params[:password_unhashed])
      @user.encrypt_password #vllt richtig??
      @user.update_attribute(:reset_key, nil) ##damit link nur einmal benutzt werden kann
      log_in @user
      flash[:success] = (I18n.t "own.success.password_reset_changed").to_s
      redirect_to '/starts'
    else
      render 'edit'
    end
  end


  private
  # gets variables
  def user_params
    params.require(:user).permit(:passwort_unhashed, :password_unhashed_confirmation)
  end
  # finds user by email
  def get_user
    @user = User.find_by(email: params[:email])
  end
  # checks if given token and token in the DB do match (reset_token)
  def valid_user
    unless @user && @user.activated?(params[:id])
    redirect_to root_url
    end
  end
  # checks if the token is expired
  def check_expiration
    if @user.password_reset_expired?
      flash[:error] = (I18n.t "own.errors.password_reset_expired").to_s
      redirect_to new_password_reset_url
    end
  end

end
