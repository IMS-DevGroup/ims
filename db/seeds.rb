# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
DataType.fill


#case Rails.env
#  when "development"
    DeviceType.fill
    Property.fill
    Unit.fill
    User.fill
    Stock.fill
    Device.fill
    Value.fill
    Operation.fill
    Lending.fill
#  when "production"


#end