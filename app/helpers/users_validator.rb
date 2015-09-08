class Users_Validator < ActiveModel::Validator

  def validate(user)

    #look for username and password combination
    if !(user.password_unhashed.blank?) && user.username.blank?
      user.errors[:base] << "If password is inserted you have to insert a username"
    elsif !(user.username.blank?) && user.password_unhashed.blank?
      user.errors[:base] << "If username is inserted you have to insert a password"
    end

    #look for correct mobile number
    if !(user.mobile_number.blank?)
      numberAfterRegex = user.mobile_number.match(/(^(\+?\-?[0-9\(]+)([,0-9]*)([0-9\.\(\)\/-])*$)/)
      if numberAfterRegex.blank?
        user.errors[:base] << "Please enter a valid mobil number"
      end
    end

    #look for unique username
    if !(user.username.blank?) then
      User.all.each do |u|
        if user.username.match(u.username) then
          user.errors[:base] << "Username already exist"
          break
        end
      end
    end

    if user.prename.blank? || user.prename.blank? then
      user.errors[:base] << "You must select a pre- and lastname"
    end
  end
end
