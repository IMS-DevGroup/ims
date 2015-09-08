class Session < ActiveRecord::Base
  belongs_to :user


  validates :session_key , presence: true

end
