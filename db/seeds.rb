# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'bcrypt'

#case Rails.env
#  when "development"

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
dt_time.name = "Datetime"
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

#Create standart value for things that can expire
dt_time= DataType.new
dt_time.name = "DateNote"
dt_time.save


    DeviceType.fill
    Property.fill
    Unit.fill
    User.fill


dt = User.new
dt.prename = "test"
dt.lastname = "user"
dt.username = "test"
dt.email=nil
dt.mobile_number="054654065401234"
dt.info="INFÖN1234"
dt.salt=BCrypt::Engine.generate_salt
dt.password = BCrypt::Engine.hash_secret("test", dt.salt)
dt.unit=Unit.first
dt.active=false
dt.save

r=Right.find_by_user_id(User.find_by_username("test"))
r.manage_devices=true
r.manage_rights=true
r.manage_users=true
r.manage_stocks_and_units=true
r.manage_device_types=true
r.manage_operations=true
r.manage_boss = true
r.save


    Stock.fill
    Device.fill
    Value.fill
    Operation.fill
    Lending.fill
#  when "production"

bc=BossConfig.new
bc.db_state=true
bc.user=User.find_by_username("test")
bc.org_name="TestOrg"
bc.save


#end