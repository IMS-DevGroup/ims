class DeviceType < ActiveRecord::Base

  has_many :devices
  has_many :properties

  validates :name , presence: true



  def self.fill


    dt_string = DeviceType.new
    dt_string.name = "DeviceType1"
    dt_string.info = "Info1"
    dt_string.save


    dt_string = DeviceType.new
    dt_string.name = "DeviceType2"
    dt_string.info = "Info2"
    dt_string.save




  end
end
