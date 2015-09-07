class User < ActiveRecord::Base
  after_validation :encrypt_password
  after_create :default_values
  before_save :nil_if_blank
  after_save :create_rights


  attr_accessor :password_unhashed

  has_one :right, dependent: :destroy
  has_one :session, dependent: :destroy

  has_many :lendings
  belongs_to :unit
  has_one :operation


  validates :prename, presence: true
  validates :lastname, presence: true
  validates :username, uniqueness: true, allow_nil: true
  validates :unit_id, presence: true
  validates_uniqueness_of :email, :allow_nil => true
  validates_with Users_Validator


  def self.authenticate(username, password_unhashed)
    user = find_by_email(username)
    if ( user == nil)
      user = find_by_username(username)
    end
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

  protected
  def default_values
    self.active = true
  end

  def create_rights
    if !self.username.nil?
      if self.right.nil?
        Right.create(:user => self)
      end
    end
  end

  def nil_if_blank
    if self.username.blank?
      self.username = nil
    end

    if self.email.blank?
      self.email = nil
    end
  end

end
