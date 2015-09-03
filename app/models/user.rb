class User < ActiveRecord::Base
  before_create :default_values


  has_one :right , dependent: :destroy
  has_one :session ,dependent: :destroy

  has_many :lendings
  belongs_to :unit
  has_one :operation



  validates :prename , presence: true
  validates :lastname , presence: true
  validates :username , uniqueness: true , allow_nil: true


  validates :unit_id , presence: true


  protected
    def default_values
      self.active = true
    end
end
