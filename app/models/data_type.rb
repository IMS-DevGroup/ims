class DataType < ActiveRecord::Base

  has_many :properties

  validates :name , presence: true



  def self.fill

    #Create standart value for String
    dt_string = DataType.new
    dt_string.name = "String"
    dt_string.save


    #Create standart value for Float
    dt_float = DataType.new
    dt_float.name = "Float"
    dt_float.save


    #Create standart value for Timestamp
    dt_time= DataType.new
    dt_time.name = "Time"
    dt_time.save


    #Create standart value for Boolean
    dt_boolean = DataType.new
    dt_boolean.name = "Boolean"
    dt_boolean.save

    #Create standart value for Integer
    #handle ths as an integer
    dt_fixnum = DataType.new
    dt_fixnum.name = "Fixnum"
    dt_fixnum.save

    DeviceType.fill
    Property.fill
    Unit.fill
    User.fill
    Stock.fill
    Device.fill
    Value.fill
    Operation.fill
    Lending.fill
  end


  end
