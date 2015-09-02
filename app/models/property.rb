class Property < ActiveRecord::Base

  has_many :values
  belongs_to :data_type
  belongs_to :device_type


end
