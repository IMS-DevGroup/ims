class Users_Validator < ActiveModel::Validator

  def validate(user)

    if !user.active?
    #look for username and password combination
    if !user.active==false
   if !(user.password_unhashed.blank?) && user.username.blank?      ##das ist komisch kann nicht erreicht werden
     user.errors[:base] << "If password is inserted you have to insert a username"
   elsif !(user.username.blank?) && user.password_unhashed.blank?
     user.errors[:base] << "If username is inserted you have to insert a password"
   end
   end
    #look for correct mobile number
    if !(user.mobile_number.blank?)
      numberAfterRegex = (user.mobile_number.to_s).match(/(^(\+?\-?[0-9\(]+)([,0-9]*)([0-9\.\(\)\/-])*$)/)
      if numberAfterRegex.blank?
        user.errors[:base] << "Please enter a valid mobil number"
      end
    end
    end
    unless user.password_unhashed.blank? && user.password_unhashed_confirmation.blank?
      if user.password_unhashed != user.password_unhashed_confirmation
        user.errors[:base] << "Passwortfelder stimmen nicht überein"
      end
    end
  end
end

