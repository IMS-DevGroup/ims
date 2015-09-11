class Property < ActiveRecord::Base

  has_many :values
  belongs_to :data_type
  belongs_to :device_type

  validates :name , presence: true
  validates :data_type_id , presence: true
  validates :device_type_id , presence: true

  def self.fill


    dt_string = Property.new
    dt_string.name = "Property1"
    dt_string.info = "Info1 String"
    dt_string.data_type= DataType.find_by_name("String")
    dt_string.device_type=DeviceType.find_by_name("DeviceType1")
    dt_string.save


    dt_string = Property.new
    dt_string.name = "Property2"
    dt_string.info = "Info2 Boolean"
    dt_string.data_type= DataType.find_by_name("Boolean")
    dt_string.device_type=DeviceType.find_by_name("DeviceType2")
    dt_string.save


    dt_string = Property.new
    dt_string.name = "Property3"
    dt_string.info = "Info3 Fixnum"
    dt_string.data_type= DataType.find_by_name("Fixnum")
    dt_string.device_type=DeviceType.find_by_name("DeviceType2")
    dt_string.save


    dt_string = Property.new
    dt_string.name = "Property4"
    dt_string.info = "Info4 Float"
    dt_string.data_type= DataType.find_by_name("Float")
    dt_string.device_type=DeviceType.find_by_name("DeviceType2")
    dt_string.save

    dt_string = Property.new
    dt_string.name = "Property5"
    dt_string.info = "Info5 Datetime"
    dt_string.data_type= DataType.find_by_name("Datetime")
    dt_string.device_type=DeviceType.find_by_name("DeviceType2")
    dt_string.save

  end
end
