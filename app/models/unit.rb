class Unit < ActiveRecord::Base

  has_many :stocks
  has_many :users
  belongs_to :user

  validates :user_id , presence: true
  validates :name , presence: true

end
