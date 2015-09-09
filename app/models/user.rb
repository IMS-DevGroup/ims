class User < ActiveRecord::Base
  after_validation :encrypt_password
  before_create :create_activation_key
  after_create :default_values
  before_save :nil_if_blank
  before_save { self.email = email.downcase if email}
  after_save :create_rights


  attr_accessor :password_unhashed, :remember_token, :activation_token, :reset_token

  has_one :right, dependent: :destroy

  has_many :lendings
  belongs_to :unit
  has_one :operation

  #this removes the extra break between label and field if error is thrown
  validates :prename, presence: true
  validates :lastname, presence: true
  validates :username, uniqueness: true, allow_nil: true
  validates :unit_id, presence: true
  validates_uniqueness_of :email, :allow_nil => true
  validates_with Users_Validator, :on => :create
  validates_with UserUpdateValidator, :on => :update




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


  def activated?(attribute, token)
    value = send("#{attribute}_key")
    return false if value == nil
    BCrypt::Password.new(value).is_password?(token)
  end

  def activate
    update_attribute(:activated, true)
    #update_attribute(:activated_at, Time.zone.now)
  end

  def send_activation_email
    UserMailer.account_acctivation(self).deliver_now
  end

  def create_reset_key
    self.reset_token = User.new_token
    update_attribute(:reset_key, BCrypt::Password.create(reset_token))
    #update_attribute(:reset_sent_at, Time.zone.now)
  end

  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

  protected
  def default_values
    self.active = true
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

  private
  def create_activation_key
    self.activation_token = User.new_token
    self.activation_key = BCrypt::Password.create(activation_token)
  end

end
