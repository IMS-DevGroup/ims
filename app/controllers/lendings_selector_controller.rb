class LendingsSelectorController < ApplicationController
  def index
    @devices = Device.all.eager_load(:stock, :device_type)
  end
  def get_devices
    devmap = @devices.map do |dev|
      { :id => dev.id, :name => dev.device_type.name, :owner => Stock.find_by_id(device.owner_id).name, :stock => dev.stock.name }
    end
    respond_to do |format|
      format.json {
        render json: { result: devmap }
      }
    end
  end
end
