class Lending < ActiveRecord::Base

  belongs_to :user
  belongs_to :device

  validates :user_id , presence: true
  validates :device_id , presence: true
  validates :lender_id , presence: true
  validates_with :Lendings_Validator




  def self.fill


    dt = Lending.new
    dt.device = Device.last
    dt.user = User.first
    dt.lender_id = User.last.id

    dt.lending_info="Glück auf"
    dt.save
    dt.receiver_id = dt.lender_id
    dt.receive= Time.now
    dt.save


    dt = Lending.new
    dt.device = Device.last
    dt.user = User.first
    dt.lender_id = User.last.id

    dt.lending_info="Gut Schlauch"
    dt.save

  end







end
