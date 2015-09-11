class LendingsController < ApplicationController
  before_action :set_lending, only: [:show, :edit, :update, :destroy, :return]
  before_action :set_devices, only: [:new, :create]
  # Global list of devices that were already selected to be borrowed in this session
  # Currently disabled remainder of first try of multiple-device-lending
  # @@global_list = []


  # GET /lendings
  # GET /lendings.json
  def index
    @lendings = Lending.all
  end

  # GET /lendings/1
  # GET /lendings/1.json
  def show
  end

  # GET /lendings/new
  def new
    puts params
    @lending = Lending.new
  end

  # GET /lendings/1/edit
  def edit
  end


  # POST /lendings
  # POST /lendings.json
  def create
    puts params
    @lending = Lending.new(lending_params)
    # handle quick-generation of user
    if params[:commit].eql?("Quick User")
      user = User.new(prename: params[:user_prename], lastname: params[:user_lastname], unit_id: params[:user_unit], info: params[:user_info])
      puts user
      if user.save
        @lending.user_id = user.id
      end
      render :new
    #submit of entire lending (currently one)
    else
      respond_to do |format|
      if @lending.save
        format.html { redirect_to @lending, notice: 'Lending was successfully created.' }
        format.json { render :show, status: :created, location: @lending }
      else
        format.html { render :new }
        format.json { render json: @lending.errors, status: :unprocessable_entity }
      end
    end

    end

  end

  # PATCH/PUT /lendings/1
  # PATCH/PUT /lendings/1.json
  def update
    respond_to do |format|
      if @lending.update(lending_params)
        format.html { redirect_to @lending, notice: 'Lending was successfully updated.' }
        format.json { render :show, status: :ok, location: @lending }
      else
        format.html { render :edit }
        format.json { render json: @lending.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lendings/1
  # DELETE /lendings/1.json
  def destroy
    @lending.destroy
    respond_to do |format|
      format.html { redirect_to lendings_url, notice: 'Lending was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # GET lendings/1/return
  def return
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lending
      @lending = Lending.find(params[:id])
    end

    def set_devices
      @devices = Device.all.eager_load(:stock, :device_type)
      devmap = {}
      @devices.each do |dev|
        devmap[dev.id] = { :type => dev.device_type.name, :owner => Unit.find_by_id(Stock.find_by_id(dev.owner_id).id).name, :stock => dev.stock.name}
      end
      gon.devices = devmap
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def lending_params
      params.require(:lending).permit(:receive, :lending_info, :receive_info, :user_id, :device_id, :lender_id, :receiver_id)
    end
end
