class User < ActiveRecord::Base
  attr_accessor :password_unhashed
  has_one :right , dependent: :destroy
  has_one :session ,dependent: :destroy

  has_many :lendings
  belongs_to :unit
  has_one :operation



  validates :prename , presence: true
  validates :lastname , presence: true
  validates :username , uniqueness: true , allow_nil: true


  #validates :unit_id , presence: true

  after_validation :encrypt_password
  after_create :default_values

  def self.authenticate(username, password_unhashed)
    user = find_by_username(username)
    if user && user.password == BCrypt::Engine.hash_secret(password_unhashed, user.salt)
      user
    else
      nil
    end
  end



  def encrypt_password
    if password_unhashed.present?
      self.salt = BCrypt::Engine.generate_salt
      self.password = BCrypt::Engine.hash_secret(password_unhashed, salt)
    end
  end
  private
    def default_values
      self.active = true
    end
end
