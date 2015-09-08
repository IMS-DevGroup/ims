class User < ActiveRecord::Base
  after_validation :encrypt_password
  after_create :default_values
  before_save :nil_if_blank
  before_save { self.email = email.downcase if email}
  after_save :create_rights


  attr_accessor :password_unhashed
  attr_accessor :remember_token

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
    return nil if username == nil
    user = find_by_username(username)
    if user == nil
      username.downcase!
      user = find_by_email(username)
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


  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def remember #####NOCH NICHT FUNKTIONSFÄHIG!!
    self.remember_token = User.new_token
    update_attribute(:cookies, BCrypt::Password.create(remember_token))
  end

  def authenticated?(remember_token) #####same
    return false if session_key == nil
    BCrypt::Password.new(cookies).is_password?(remember_token)
  end

  def forget
    update_attribute(:cookies, nil)
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
