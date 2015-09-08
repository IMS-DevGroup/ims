class Device < ActiveRecord::Base

  has_many :lendings
  has_many :values
  belongs_to :device_type
  belongs_to :stock

  validates :owner_id, presence: :true
  validates :ready , presence: true
  validates :stock_id, presence: :true

end
