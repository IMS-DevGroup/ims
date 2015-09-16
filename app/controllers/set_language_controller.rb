class SetLanguageController < ApplicationController
  def english
    if current_user then
      I18n.locale = :en
      @current_user[:language] = I18n.locale
    set_session_and_redirect
      end
  end

  def german
    if current_user then
    I18n.locale = :de
     @current_user[:language] = I18n.locale
    I18n.locale = @current_user[:language]
    set_session_and_redirect
    end
  end

  private
  def set_session_and_redirect
    session[:locale] = @current_user[:language]
    redirect_to :back
  rescue ActionController::RedirectBackError
    redirect_to :root
  end
end
