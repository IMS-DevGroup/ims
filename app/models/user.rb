class User < ActiveRecord::Base
  before_save :encrypt_password
  after_create :default_values
  before_save :nil_if_blank
  before_validation { self.email = email.downcase if email}
  before_validation { self.username = username.downcase if username}
  after_save :create_rights


  attr_accessor :password_unhashed, :password_unhashed_confirmation, :remember_token, :reset_token

  has_one :right, dependent: :destroy

  has_many :lendings
  belongs_to :unit

  has_one :boss_config

  has_many :operation
  belongs_to :stock
  has_many :notifications

  #this removes the extra break between label and field if error is thrown
  validates :prename, presence: true
  validates :lastname, presence: true
  validates :username, :uniqueness => {:case_sensitive => false}, allow_nil: true
  validates :unit_id, presence: true
  validates_uniqueness_of :email, :allow_nil => true
  validates_with Users_Validator, :on => :create
  validates_with UserUpdateValidator, :on => :update




  # authenticates the user by checking if the given username or email exists and has a valid login
  # with the given password
  def self.authenticate(username, password_unhashed)
    return nil if username == nil
    username.downcase!
    user = find_by_username(username)
    if user == nil
      user = find_by_email(username)
    end
    if user && user.password == BCrypt::Engine.hash_secret(password_unhashed, user.salt)
      user
    else
      nil
    end
  end

  # Checks whether there is an unhashed password given, if it exists it will get hashed in combination with a salt
  def encrypt_password
    if self.password_unhashed.present?
      self.salt = BCrypt::Engine.generate_salt
      self.password = BCrypt::Engine.hash_secret(password_unhashed, salt)
    end
  end

  # Generates a random token (example: reset_-, renember_token)
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # Generates a token and saves it encrypted into the database
  def remember
    self.remember_token = User.new_token
    update_attribute(:cookies, BCrypt::Password.create(remember_token))
  end

  # checks whether the user has a valid cookie or not.
  def authenticated?(remember_token)
    return false if cookies == nil
    BCrypt::Password.new(cookies).is_password?(remember_token)
  end

  # forgets user by deleting the cookie_id from the database
  def forget
    update_attribute(:cookies, nil)
  end

  # Checks whether the given reset_token does match the reset_key in the database or not
  def activated?(reset_token)
    return false if reset_key == nil
    BCrypt::Password.new(reset_key).is_password?(reset_token)
  end

  # gets called if a user gets created without a password, but with username and email
  # generates a random password and sends it to the new user
  def activate
    self.password_unhashed = SecureRandom.urlsafe_base64(6, false)
    self.password_unhashed_confirmation = password_unhashed
    save
    UserMailer.account_activation(self, password_unhashed).deliver_now
  end

  # Creates a reset_token and reset_key using the Bcrypt Algorithm and generates a timestamp
  def create_reset_key
      self.reset_token = User.new_token
      update_attribute(:reset_key, BCrypt::Password.create(reset_token))
      update_attribute(:reset_sent_at, Time.zone.now)
  end

  # Sends the password_reset email
  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  #checks if the password-reset link is already expired (it expires after 2 hours)
  def password_reset_expired?
    reset_sent_at <= 2.hours.ago
  end

  protected
  def default_values
    self.active = true
    self.save
  end

  def create_rights
    if !self.username.nil?
      if Right.find_by_user_id(self.id).nil?
        Right.create(:user => self)
      end
    end
  end

  #checks for blank username, saves it as nil in the database, not as empty string anymore
  #checks for blank email, saves it as nil in the database, not as empty string anymore
  def nil_if_blank
    if self.username.blank?
      self.username = nil
    end

    if self.email.blank?
      self.email = nil
    end
  end

  def self.fill


    dt = User.new
    dt.prename = "prename"
    dt.lastname = "lastname"
    dt.unit=Unit.first
    dt.save


  end
end
