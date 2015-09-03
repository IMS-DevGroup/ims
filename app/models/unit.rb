class Unit < ActiveRecord::Base

  has_many :stocks
  has_many :users



  validates :name , presence: true

end
