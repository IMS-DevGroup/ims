class Operation < ActiveRecord::Base

  belongs_to :user
  has_and_belongs_to_many :stocks

  validates :location , presence: true
  #validates :user_id, presence: true

end
