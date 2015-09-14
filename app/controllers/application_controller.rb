class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper

  helper :all
  protect_from_forgery
  layout :detect_browser

  before_filter :require_login

  def require_login
    if NO_LOGIN_ROUTES.include? request.env['PATH_INFO']
      return
    end
    unless current_user
      redirect_to '/login/'
    end
  end

  def detect_browser
    agent = request.headers["HTTP_USER_AGENT"].downcase
    MOBILE_BROWSERS.each do |m|
      return "application_mobile" if agent.match(m)
    end
    return "application"
  end


  private
  MOBILE_BROWSERS = ["android", "ipod", "opera mini", "blackberry", "palm","hiptop","avantgo","plucker", "xiino","blazer","elaine", "windows ce; ppc;", "windows ce; smartphone;","windows ce; iemobile", "up.browser","up.link","mmp","symbian","smartphone", "midp","wap","vodafone","o2","pocket","kindle", "mobile","pda","psp","treo"]
  NO_LOGIN_ROUTES = ["/contacts"]



  before_filter :set_locale

  #checks default browser language
  private
  def extract_locale_from_accept_language_header
    request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
  end

  #sets localisation (magic)
  private
  def set_locale

    I18n.locale = session[:locale] || I18n.default_locale
    session[:locale] = I18n.locale
    gon.locale = I18n.locale
  end


end
