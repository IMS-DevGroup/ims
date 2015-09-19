class DeviceTypesController < ApplicationController
  before_action :set_device_type, only: [:show, :edit, :update, :destroy]

  # GET /device_types
  # GET /device_types.json
  def index
    @device_types = DeviceType.all
  end

  # GET /device_types/1
  # GET /device_types/1.json
  def show
  end

  # GET /device_types/new
  def new
    if BossConfig.first.db_state == false
      flash[:error] = (I18n.t "own.errors.db_offline").to_s
      redirect_to "/starts/"
    else
    @device_type = DeviceType.new
  end
end
  # GET /device_types/1/edit
  def edit
    if BossConfig.first.db_state == false
      flash[:error] = (I18n.t "own.errors.db_offline").to_s
      redirect_to "/starts/"
    end
  end

  # POST /device_types
  # POST /device_types.json
  def create
    if BossConfig.first.db_state == false
      flash[:error] = (I18n.t "own.errors.db_offline").to_s
      redirect_to "/starts/"
    else
    @device_type = DeviceType.new(device_type_params)

    respond_to do |format|
      if @device_type.save
        flash[:success] = (I18n.t "own.success.device_type_created").to_s
        format.html { redirect_to @device_type }
        format.json { render :show, status: :created, location: @device_type }
      else
        flash.now[:error] = (@device_type.errors.values).join("<br/>").html_safe
        format.html { render :new }
        format.json { render json: @device_type.errors, status: :unprocessable_entity }
      end
    end
  end
end
  # PATCH/PUT /device_types/1
  # PATCH/PUT /device_types/1.json
  def update
    if BossConfig.first.db_state == false
      flash[:error] = (I18n.t "own.errors.db_offline").to_s
      redirect_to "/starts/"
    else
    respond_to do |format|
      if @device_type.update(device_type_params)
        flash[:success] = (I18n.t "own.success.device_type_updated").to_s
        format.html { redirect_to @device_type }
        format.json { render :show, status: :ok, location: @device_type }
      else
        flash.now[:error] = (@device_type.errors.values).join("<br/>").html_safe
        format.html { render :edit }
        format.json { render json: @device_type.errors, status: :unprocessable_entity }
      end
    end
  end
end
  # DELETE /device_types/1
  # DELETE /device_types/1.json
  def destroy
    @device_type.destroy
    respond_to do |format|
      flash[:success] = (I18n.t "own.success.device_type_destroyed").to_s
      format.html { redirect_to @device_type }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_device_type
      @device_type = DeviceType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def device_type_params
      params.require(:device_type).permit(:name, :info)
    end
end
