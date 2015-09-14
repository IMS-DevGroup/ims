class UserUpdateValidator < ActiveModel::Validator


  def validate(user)
    #look for correct mobile number
    if !(user.mobile_number.blank?)
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
    end
    unless user.password_unhashed == nil ##test
      if user.password_unhashed != user.password_unhashed_confirmation
        user.errors[:base] << "Passwortfelder stimmen nicht überein"
      end
    end
  end
end


