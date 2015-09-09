class Lending < ActiveRecord::Base

  belongs_to :user
  belongs_to :device

  validates :user_id , presence: true, :on => :create
  validates :device_id , presence: true, :on => :create
  validates :lender_id , presence: true, :on => :create
  validates_with Lendings_Validator , presence: true
end
