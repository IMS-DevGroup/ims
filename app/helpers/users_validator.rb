class Users_Validator < ActiveModel::Validator

  def validate(user)


    #look for username and password combination
    if !(user.password_unhashed.blank?) && user.username.blank?
      user.errors[:base] << (I18n.t "own.errors.only_pw_no_username").to_s
    elsif !(user.username.blank?) && user.password_unhashed.blank?
      user.errors[:base] << (I18n.t "own.errors.only_username_no_pw").to_s
    end

    #look for correct mobile number
    if !(user.mobile_number.blank?)
      numberAfterRegex = (user.mobile_number.to_s).match(/(^(\+?\-?[0-9\(]+)([,0-9]*)([0-9\.\(\)\/-])*$)/)
      if numberAfterRegex.blank?
        user.errors[:base] << (I18n.t "own.errors.mobile_number_not_valid").to_s
      end
    end
  end
end
