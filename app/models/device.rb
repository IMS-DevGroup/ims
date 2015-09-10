class Device < ActiveRecord::Base



  has_many :lendings
  has_many :values
  belongs_to :device_type
  belongs_to :stock

  validates :owner_id, presence: :true

  validates :stock_id, presence: :true




  def self.fill


    dt = Device.new
    dt.stock = Stock.find_by_name("Stock1")
    dt.device_type = DeviceType.find_by_name("DeviceType1")
    dt.info = "Info1"
    dt.ready=true
    dt.owner_id=User.last.id
    dt.save



    dt= Device.new
    dt.stock = Stock.find_by_name("Stock2")
    dt.device_type = DeviceType.find_by_name("DeviceType2")
    dt.info = "Info2"
    dt.ready=true
    dt.owner_id=User.first.id
    dt.save

  end


end
