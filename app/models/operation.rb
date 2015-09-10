class Operation < ActiveRecord::Base

  belongs_to :user
  has_and_belongs_to_many :stocks

  validates :location , presence: true
  validates :user_id, presence: true
  validates :operation_type, presence: true


  def self.fill


    dt = Operation.new
    dt.location = "Osnabrück"
    dt.user = User.last
    dt.operation_type = "Operation_1"
    dt.save

    dt = Operation.new
    dt.location = "Borken"
    dt.user = User.first
    dt.operation_type ="Operation_2"
    dt.save

    dt = Operation.new
    dt.location = "Meppen"
    dt.user = User.first
    dt.operation_type="Operation_3"
    dt.save


  end

end
