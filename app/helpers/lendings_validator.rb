class Lendings_Validator < ActiveModel::Validator

  def validate(lending)
    if User.find_by_id(lending.lender_id).nil? then lending.errors[:base] = "Lender does not exist"
    elsif User.find_by_id(lending.user_id).nil? then lending.errors[:base] = "User does not exist"
    elsif Device.find_by_id(lending.device_id).nil? then lending.errors[:base] = "Device does not exist"
    end

  end
end