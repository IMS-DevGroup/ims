class DevicesController < ApplicationController
  before_action :set_device, only: [:show, :edit, :update, :destroy]

  # GET /devices
  # GET /devices.json
  def index
    @devices = Device.all.eager_load(:stock, :device_type)
  end

  # GET /devices/1
  # GET /devices/1.json
  def show
  end

  # GET /devices/new
  def new
    @device = Device.new
  end

  # GET /devices/1/edit
  def edit
  end

  # POST /devices
  # POST /devices.json
  def create
    @device = Device.new(device_params)

    respond_to do |format|
      if @device.save
        flash[:success] = (I18n.t "own.success.device_created").to_s
        format.html { redirect_to @device }
        format.json { render :show, status: :created, location: @device }
      else
        #get all error messages and save it into a string
        flash.now[:error] = (@device.errors.values).join("<br/>").html_safe
        format.html { render :new }
        format.json { render json: @device.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /devices/1
  # PATCH/PUT /devices/1.json
  def update
    respond_to do |format|
      if @device.update(device_params)
        flash[:success] = (I18n.t "own.success.device_updated").to_s
        format.html { redirect_to @device }
        format.json { render :show, status: :ok, location: @device }
      else
        flash.now[:error] = (@device.errors.values).join("<br/>").html_safe
        format.html { render :edit }
        format.json { render json: @device.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /devices/1
  # DELETE /devices/1.json
  def destroy
    @device.destroy
    respond_to do |format|
      format.html { redirect_to devices_url, notice: 'Device was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def get_properties
    prop_ary = Array.new
    DeviceType.find_by_id(params[:device_type]).properties.each do |property|
      prop_ary.push(property)
    end
    respond_to do |format|
      format.json {
        render json: { result: prop_ary }
      }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_device
      @device = Device.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def device_params
      params.require(:device).permit(:ready, :info, :owner_id, :value_id, :stock_id, :device_type_id)
    end
end
