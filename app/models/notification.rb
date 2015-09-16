class Notification < ActiveRecord::Base
  belongs_to :user
  belongs_to :unit
  belongs_to :device

  validates :device_id, presence: true
  validates :unit_id, presence: true


end
