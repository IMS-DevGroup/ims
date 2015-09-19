class Lendings_Validator < ActiveModel::Validator

  def validate(lending)
    if User.find_by_id(lending.lender_id).nil? then lending.errors[:base] = (I18n.t "own.errors.lender_not_exists")
    elsif User.find_by_id(lending.user_id).nil? then lending.errors[:base] = (I18n.t "own.errors.user_not_exists")
    elsif (@dev = Device.find_by_id(lending.device_id)).nil? then lending.errors[:base] = (I18n.t "own.errors.device_not_exists")
    elsif !((@len = @dev.active_lending).nil?) then
      lending.errors[:base] = "Device has already been lended to " + @len.user.prename + " " + @len.user.lastname + " on " + @len.created_at.to_s
    end
    if !(lending.receiver_id.blank?) or !(lending.receive.blank?) or !(lending.receive_info.blank?)
      if lending.receiver_id.blank? then lending.errors[:base] = (I18n.t "own.errors.receive_problem")
      elsif lending.receive.blank? then lending.errors[:base] = (I18n.t "own.errors.receiver_not_exists")
      elsif User.find_by_id(lending.receiver_id).nil? then lending.errors[:base] = (I18n.t "own.errors.receiver_not_exists")
      end
    end

  end
end