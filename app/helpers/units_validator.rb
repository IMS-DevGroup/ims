class Units_Validator < ActiveModel::Validator

  def validate(unit)

  #look for correct mobile number
  if !(unit.phone_number.blank?)
    puts "hier kommt die maus"
    puts unit.phone_number
    numberAfterRegex = (unit.phone_number.to_s).match(/(^(\+?\-?[0-9\(]+)([,0-9]*)([0-9\.\(\)\/-])*$)/)
    if numberAfterRegex.blank?
      unit.errors[:base] << "Please enter a valid mobil number"
    end
  end
  end
end

