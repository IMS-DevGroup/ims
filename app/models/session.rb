class Session < ActiveRecord::Base
  belongs_to :user

  validates :user_id , presence: true
  validates :session_key , presence: true
end
