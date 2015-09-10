class LendingsSelectorController < ApplicationController
  def index
    @devices = Device.all.eager_load(:stock, :device_type)
    devmap = {}
    @devices.each do |dev|
      devmap[dev.id] = dev
    end
    gon.devices = devmap
  end
end
