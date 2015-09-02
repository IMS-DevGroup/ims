class Unit < ActiveRecord::Base

  has_many :stocks
  has_many :users
  belongs_to :user

end
