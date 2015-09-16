class LendingsController < ApplicationController
  before_action :set_lending, only: [:show, :edit, :update, :destroy, :return]
  before_action :set_devices, :pick_user_data, only: [:new, :create]
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
    if BossConfig.first.db_state == false
      flash[:error] = (I18n.t "own.errors.db_offline").to_s
      redirect_to "/starts/"
    else
      @lending = Lending.new
      @quick_usr = {}
    end
  end

  # GET /lendings/1/edit
  def edit
  end


  # POST /lendings
  # POST /lendings.json
  def create
    puts params
    if BossConfig.first.db_state == false
      flash[:error] = (I18n.t "own.errors.db_offline").to_s
      redirect_to "/starts/"
    else

      @lending = Lending.new(lending_params)
      @device_list = params[:deviceids].delete(' ').split(',')
      @errors = []
      @error_lendings = []
      @quick_usr = {}
      names = params[:user_auto].split(',')
      autofill_user = User.find_by_lastname_and_prename( names[0] , names[1] )
      tmp_params = lending_params
      tmp_params[:user_id] = autofill_user.id

      # handle quick-generation of user
      if params[:commit].eql?("Quick User")
        if quick_user_generation
          return
        end

        #submission of entire lending
      else
        devlen = @device_list.length
        #artificially recreate device can't be blank error
        if @device_list.empty?
          @lending.save
          @errors << @lending.errors
          try to create and save lendings
        else
          @device_list.each do |d|
            tmp_params[:device_id] = d
            @lending = Lending.new(tmp_params)
            if @lending.save

            else
              @errors.push(@lending.errors)
              @error_lendings.push(d)
            end
          end
          @device_list = @error_lendings
        end
      end

      # handles either a failed user-generation or the creation of the actual lending
      respond_to do |format|
        if @errors.empty?
          format.html { redirect_to '/lendings', notice: devlen.to_s + ' lendings were successfully created.' }
          format.json { render :show, status: :created, location: @lending }
        else
          if (devlen > @device_list.length)
            flash.now[:success] = ((devlen - @device_list.length).to_s + ' of ' + devlen.to_s + ' lendings were successfully created').html_safe
          end
          errors_to_flash = []
          @errors.each do |e|
            errors_to_flash << ((e.values).join("<br/>").html_safe)
          end
          flash.now[:error] = errors_to_flash.join("<br/>").html_safe
          set_selected_devices
          format.html { render :new }
          format.json { render json: @errors, status: :unprocessable_entity }
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
    if BossConfig.first.db_state == false
      flash[:error] = (I18n.t "own.errors.db_offline").to_s
      redirect_to "/starts/"
    else
      @lending.destroy
      respond_to do |format|
        format.html { redirect_to lendings_url, notice: 'Lending was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  end

  # GET lendings/1/return
  def return
    if BossConfig.first.db_state == false
      flash[:error] = (I18n.t "own.errors.db_offline").to_s
      redirect_to "/starts/"
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_lending
    if BossConfig.first.db_state == false
      flash[:error] = (I18n.t "own.errors.db_offline").to_s
      redirect_to "/starts/"
    else
      @lending = Lending.find(params[:id])
    end
  end

  # Set all devices for later use in device-selector-coffeescript
  def set_devices
    if BossConfig.first.db_state == false
      flash[:error] = (I18n.t "own.errors.db_offline").to_s
      redirect_to "/starts/"
    else
      #check for set stock
      if @current_user.stock.nil?
        @devices = Device.all.eager_load(:stock, :device_type)
      else
        @devices = Device.where(stock_id: @current_user.stock_id).find_each
      end
      devmap = {}
      @devices.each do |dev|
        if dev.available?
          devmap[dev.id] = {:type => dev.device_type.name, :owner => Unit.find_by_id(Stock.find_by_id(dev.owner_id).id).name, :stock => dev.stock.name}
        end
      end
      gon.devices = devmap
    end
  end

  def pick_user_data
    users = User.all
    usrmap = []
    users.each do |user|
      usrmap << user.lastname.to_s + ',' + user.prename.to_s
    end
    gon.users = usrmap
  end

  # Set selected devices for later use in device-selector-coffeescript
  def set_selected_devices
    gon.selected_devices = @device_list
  end

  # Try to generate a new user from data in params, return true if successful
  def quick_user_generation
    @quick_usr[:prename] = params[:user_prename]
    @quick_usr[:lastname] = params[:user_lastname]
    @quick_usr[:unit_id] = params[:user_unit]
    @quick_usr[:info] = params[:user_info]
    user = User.new(@quick_usr)
    if user.save
      @lending.user_id = user.id
      set_selected_devices
      render :new
      return true
    else
      @errors.push(user.errors)
      return false
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def lending_params
    params.require(:lending).permit(:receive, :lending_info, :receive_info, :user_id, :device_id, :lender_id, :receiver_id)
  end
end
