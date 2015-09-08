class Stocks_Validator < ActiveModel::Validator

  def validate(stock)

    if stock.name.blank?
      stock.errors[:base] <<"Insert Name!"
    end

  end
end
