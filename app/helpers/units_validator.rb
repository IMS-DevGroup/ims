class Units_Validator < ActiveModel::Validator

  def validate(unit)

    if stock.name.blank?
      stock.errors[:base] <<"Insert Name!"

    end
  end
end