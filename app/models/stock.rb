class Stock < ActiveRecord::Base

  has_many :devices
  belongs_to :unit
  has_and_belongs_to_many :operations


end
