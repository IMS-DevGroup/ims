class Users_Validator < ActiveModel::Validator

  def validate(user)


    #look for username and password combination
    if !user.active==false
      if !(user.password_unhashed.blank?) && user.username.blank?
        user.errors[:base] << (I18n.t "own.errors.only_pw_no_username")
      elsif !(user.username.blank?) && user.password_unhashed.blank?
        user.errors[:base] << (I18n.t "own.errors.only_username_no_pw")
      end
    end
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

  end
end

