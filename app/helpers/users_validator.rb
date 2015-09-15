class Users_Validator < ActiveModel::Validator

  def validate(user)
    if !(user.password_unhashed.blank?) && user.username.blank?
      user.errors[:base] << (I18n.t "own.errors.only_pw_no_username")
    elsif !(user.username.blank?) && user.password_unhashed.blank? && user.email.blank?
     user.errors[:base] << (I18n.t "own.errors.only_username_no_pw")
    end
    #look for correct mobile number
    unless user.mobile_number.blank?
      numberAfterRegex = (user.mobile_number.to_s).match(/(^(\+?\-?[0-9\(]+)([,0-9]*)([0-9\.\(\)\/-])*$)/)
      if numberAfterRegex.blank?
        user.errors[:base] << (I18n.t "own.errors.mobile_number_not_valid")
      end
    end
    #username validator: first character must be a letter, than letters, numbers and _/. allowed
    if !(user.username.blank?)
      usernameAfterRegex = (user.username.to_s).match(/^(?![0-9_.])[a-zA-Z0-9_.]+$/)
      if usernameAfterRegex.blank?
        user.errors[:base] << (I18n.t "own.errors.username")
      end

      # if a user gets created with a password, the password has to be confirmed in an extra password_field
      unless user.password_unhashed.blank? && user.password_unhashed_confirmation.blank?
        if user.password_unhashed != user.password_unhashed_confirmation
          user.errors[:base] << (I18n.t "own.errors.password_confirmation")
        end
      end
    end
  end
end

