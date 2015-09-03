class DeviceType < ActiveRecord::Base

  has_many :devices
  has_many :properties

  validates :name , presence: true
end
