class UserUpdateValidator < ActiveModel::Validator


  def validate(user)
    #look for correct mobile number
    if !(user.mobile_number.blank?)
      numberAfterRegex = (user.mobile_number.to_s).match(/(^(\+?\-?[0-9\(]+)([,0-9]*)([0-9\.\(\)\/-])*$)/)
      if numberAfterRegex.blank?
        user.errors[:base] << "Please enter a valid mobil number"
      end
    end
    unless user.password_unhashed == nil ##test
      if user.password_unhashed != user.password_unhashed_confirmation
        user.errors[:base] << "Passwortfelder stimmen nicht überein"
      end
    end
  end
end


