class User < ActiveRecord::Base
  has_one :right , dependent: :destroy
  has_one :session ,dependent: :destroy

  has_many :lendings
  belongs_to :unit
  has_one :unit
  has_one :operation



  validates :prename , presence: true
  validates :lastname , presence: true
  validates :username , uniqueness: true
  validates :unit_id , presence: true

  after_create :default_values

  private
    def default_values
      self.active = true
    end
end
