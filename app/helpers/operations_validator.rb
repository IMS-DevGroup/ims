class Operations_Validator < ActiveModel::Validator
  def validate(operation)
    if operation.type.blank? && !(operation.location.blank?)
      operation.errors[:base] << "Operationtype not insert!"
    elsif
      operation.location.blank? && !(operation.operation_type.blank?)
      operation.errors[:base] <<"Location not insert!"
    end
  end
end
