class Lendings_Validator < ActiveModel::Validator

  def validate(lending)
    if User.find_by_id(lending.lender_id).nil? then lending.errors[:base] = "Lender does not exist"
    elsif User.find_by_id(lending.user_id).nil? then lending.errors[:base] = "User does not exist"
    elsif Device.find_by_id(lending.device_id).nil? then lending.errors[:base] = "Device does not exist"
    end
    if !(lending.receiver_id.blank?) or !(lending.receive.blank?) or !(lending.receive_info.blank?)
      if lending.receiver_id.blank? then lending.errors[:base] = "Receiver cannot be blank when other receive-data exists"
      elsif lending.receive.blank? then lending.errors[:base] = "Receive cannot be blank when other receive-data exists"
      elsif User.find_by_id(lending.receiver_id).nil? then lending.errors[:base] = "Receiver does not exist"
      end
    end

  end
end