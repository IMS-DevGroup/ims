class DevicesController < ApplicationController
  before_action :set_device, only: [:show, :edit, :update, :destroy]

  # GET /devices
  # GET /devices.json
  def index
    #check for set stock
    if @current_user.stock.nil?
      @devices = Device.all.eager_load(:stock, :device_type)
    else
      @devices = Device.where(stock_id: @current_user.stock_id).find_each
    end
  end


  # GET /devices/1
  # GET /devices/1.json
  def show
  end

  # GET /devices/new
  def new
    if current_user.right.manage_devices == false
      redirect_to "/devices/"
    elsif BossConfig.first.db_state == false
      flash[:error] = 'Datenbank Status: Im Einsatz, keine keine Änderung mölgich'
      redirect_to "/devices/"
    else
      @device = Device.new

      properties = Property.all
      propmap = {}

      properties.each do |prop|
        propmap[prop.id] = { :id => prop.id, :name => prop.name, :data_type => DataType.find_by_id(prop.data_type_id).name,
                             :device_type => prop.device_type.id, :value => nil }
      end
      gon.properties = propmap
    end
  end

  # GET /devices/1/edit
  def edit
    if current_user.right.manage_devices == false
      redirect_to "/devices/"

    elsif BossConfig.first.db_state == false
        flash[:error] = 'Datenbank Status: Im Einsatz, keine keine Änderung mölgich'
        redirect_to "/devices/"

    else
      properties = Property.where("device_type_id = ?", @device.device_type_id)
      propmap = {}

      properties.each do |prop|
        value = prop.values.find_by_device_id(@device.id).value
        propmap[prop.id] = { :id => prop.id, :name => prop.name, :data_type => DataType.find_by_id(prop.data_type_id).name,
                             :device_type => prop.device_type.id, :value => value }
      end
      gon.properties = propmap
    end
  end

  # POST /devices
  # POST /devices.json
  def create
    @device = Device.new(device_params)

    respond_to do |format|
      if @device.save
        ValuesController.insert(params['prop_val'], params['prop_id'], @device)
        flash[:success] = (I18n.t "own.success.device_created").to_s
        format.html { redirect_to @device }
        format.json { render :show, status: :created, location: @device }
      else
        # get all error messages and save it into a string
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
        ValuesController.change(params['prop_val'], params['prop_id'], @device)
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
    if BossConfig.first.db_state == false
      redirect_to "/devices/"
      flash[:error] = 'Datenbank Status: Im Einsatz, keine keine Änderung mölgich'
    else
      @device.values.each do |v|
        v.destroy
      end

      @device.destroy
      respond_to do |format|
        flash[:success] = (I18n.t "own.success.device_destroyed").to_s
        format.html { redirect_to @device }
        format.json { head :no_content }
      end
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_device
    @device = Device.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def device_params
    params.require(:device).permit(:ready, :info, :owner_id, :stock_id, :device_type_id, :data_type_id, :device_group_id)
  end

end
