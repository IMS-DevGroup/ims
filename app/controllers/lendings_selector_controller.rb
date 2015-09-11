class LendingsSelectorController < ApplicationController
  def index
    @devices = Device.all.eager_load(:stock, :device_type)
    devmap = {}
    @devices.each do |dev|
      devmap[dev.id] = { :type => dev.device_type.name, :owner => Unit.find_by_id(Stock.find_by_id(dev.owner_id).id).name, :stock => dev.stock.name}
    end
    gon.devices = devmap
  end
end
