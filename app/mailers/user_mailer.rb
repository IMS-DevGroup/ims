class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.account_activation.subject
  #
  def account_activation(user, tmp_password)
    @user = user
    @tmp_password = tmp_password

    mail to: user.email, subject: "Aktivierung des Accounts"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_reset.subject
  #
  def password_reset(user)
    @user = user

    mail to: user.email, subject: "Passwort zurücksetzen"
  end

  default from: 'Kontakt.IMS@fw-technology.com'
  #def welcome_email(email)
  #  mail(to: email, subject: 'Willkommen!')
  #end

end