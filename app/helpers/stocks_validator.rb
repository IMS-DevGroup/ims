class Stocks_Validator < ActiveModel::Validator
  def validate(stock)
    if stock.name.blank?
      puts "hier sollte ich hin"
      stock.errors[:base] <<"Insert Name!"
    end

  end
end
