class User < ActiveRecord::Base
  before_create :default_values
  after_save :create_rights
  before_save :nil_if_blank


  has_one :right, dependent: :destroy
  has_one :session, dependent: :destroy

  has_many :lendings
  belongs_to :unit
  has_one :operation

  validates :prename, presence: true
  validates :lastname, presence: true
  validates :username, uniqueness: true, allow_nil: true
  validates :unit_id, presence: true

  #Regex for valid usermail
  validates_format_of :email, :with =>/\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i


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
  end
end
