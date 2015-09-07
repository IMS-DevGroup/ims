class Users_Validator < ActiveModel::Validator
  def validate(user)
    if !(user.password_unhashed.blank?) && user.username.blank?
      user.errors[:base] << "If password is inserted you have to insert a username"
    elsif !(user.username.blank?) && user.password_unhashed.blank?
      user.errors[:base] << "If username is inserted you have to insert a password"
    end
  end
end