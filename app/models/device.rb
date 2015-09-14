class Device < ActiveRecord::Base
  require 'rufus-scheduler'
  scheduler = Rufus::Scheduler.new


  has_many :lendings
  has_many :values
  belongs_to :device_type
  belongs_to :stock
  belongs_to :device_group


  validates :owner_id, presence: :true

  validates :stock_id, presence: :true


  scheduler.every '60s' do
    puts 'Hello... Rufus'
    Device.throw_expired_note
  end

  def self.throw_expired_note
    puts "hello world"
    Device.all.each do |d|
      d.values.each do |v|
        if v.property.data_type.name == "DateNote" && Time.parse(v.value) < Time.now
          n=Notification.new
          n.subject="Let Up: "+ d.info + "ist abgelaufen"
          n.info="Ablaufdatum: " + v.value
          n.unit=Stock.find(d.owner_id).unit
          n.save
          end
       end
      end
  end

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
