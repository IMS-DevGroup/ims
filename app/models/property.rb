class Property < ActiveRecord::Base

  has_many :values
  belongs_to :data_type
  belongs_to :device_type

  validates :name , presence: true
  validates :data_type_id , presence: true
  validates :device_type_id , presence: true

end
