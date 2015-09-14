class User < ActiveRecord::Base
  before_save :encrypt_password
  after_create :default_values
  before_save :nil_if_blank
  before_validation { self.email = email.downcase if email}
  before_validation { self.username = username.downcase if username}
  after_save :create_rights


  attr_accessor :password_unhashed, :password_unhashed_confirmation, :remember_token, :reset_token, :activation_token

  has_one :right, dependent: :destroy

  has_many :lendings
  belongs_to :unit
  has_many :operation

  #this removes the extra break between label and field if error is thrown
  validates :prename, presence: true
  validates :lastname, presence: true
  validates :username, uniqueness: true, allow_nil: true
  validates :unit_id, presence: true
  validates_uniqueness_of :email, :allow_nil => true
  #validates :password_unhashed, confirmation: true
  validates_with Users_Validator, :on => :create
  validates_with UserUpdateValidator, :on => :update




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


  def encrypt_password
    if self.password_unhashed.present?
      puts "encrypt1"
      self.salt = BCrypt::Engine.generate_salt
      puts self.salt
      puts self.username
      self.password = BCrypt::Engine.hash_secret(password_unhashed, salt)
      puts self.password

    end
    puts "encrypt2"
  end


  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:cookies, BCrypt::Password.create(remember_token))
  end

  def authenticated?(remember_token)
    return false if cookies == nil
    BCrypt::Password.new(cookies).is_password?(remember_token)
  end

  def forget
    update_attribute(:cookies, nil)
  end

  def activated?(token)
    return false if reset_key == nil
    BCrypt::Password.new(reset_key).is_password?(token)
  end

  def activate
    self.password_unhashed = SecureRandom.urlsafe_base64(6, false)
    #self.encrypt_password
    save
    send_activation_email
  end

  def create_activation_key
    self.activation_token = User.new_token
    update_attribute(:reset_key, BCrypt::Password.create(activation_token))
  end


  def send_activation_email
    UserMailer.account_activation(self, self.password_unhashed).deliver_now
  end

  def create_reset_key
      self.reset_token = User.new_token
      update_attribute(:reset_key, BCrypt::Password.create(reset_token))
      update_attribute(:reset_sent_at, Time.zone.now)
  end

  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

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


    dt = User.new
    dt.prename = "test"
    dt.lastname = "user"
    dt.username = "test"
    dt.email=nil
    dt.mobile_number="054654065401234"
    dt.info="INFÖN1234"
    dt.salt=BCrypt::Engine.generate_salt
    dt.password = BCrypt::Engine.hash_secret("test", dt.salt)
    dt.unit=Unit.first
    dt.active=false
    dt.save


  end
end
