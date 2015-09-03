class User < ActiveRecord::Base
  has_one :right, dependent: :destroy
  has_one :session, dependent: :destroy

  has_many :lendings
  belongs_to :unit
  has_one :operation

  validates :prename, presence: true
  validates :lastname, presence: true
  validates :username, uniqueness: true, allow_nil: true


  validates :unit_id, presence: true

  after_create :default_values

  before_save :nil_if_blank


  private
  def default_values
    self.active = true
  end

  def nil_if_blank
    if self.username.blank?
      self.username = nil
    end
  end

end
