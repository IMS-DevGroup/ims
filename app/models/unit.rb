class Unit < ActiveRecord::Base

  has_many :stocks
  has_many :users
  has_many :notifications



  validates :name , presence: true
  validates_with Units_Validator




  def self.fill


    dt = Unit.new
    dt.name = "Unit1"
    dt.info = "Info1"
    dt.save


    dt= Unit.new
    dt.name = "Unit2"
    dt.info = "Info2"
    dt.save


    dt= Unit.new
    dt.name = "Unit3"
    dt.info = "Info3"
    dt.save


    dt= Unit.new
    dt.name = "Unit4"
    dt.info = "Info4"
    dt.save

  end

end
