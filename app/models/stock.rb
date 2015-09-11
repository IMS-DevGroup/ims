class Stock < ActiveRecord::Base

  has_many :users
  has_many :devices
  belongs_to :unit
  has_and_belongs_to_many :operations

  validates :unit_id , presence: true
  validates :name , presence: true

  def self.fill


    dt_string = Stock.new
    dt_string.name = "Stock1"
    dt_string.info = "Info1"
    dt_string.unit = Unit.first
    dt_string.save


    dt_string = Stock.new
    dt_string.name = "Stock2"
    dt_string.info = "Info2"
    dt_string.unit = Unit.first
    dt_string.save


    dt_string = Stock.new
    dt_string.name = "Stock3"
    dt_string.info = "Info3"
    dt_string.unit = Unit.last
    dt_string.save


    dt_string = Stock.new
    dt_string.name = "Stock4"
    dt_string.info = "Info4"
    dt_string.unit = Unit.last
    dt_string.save

  end


end
