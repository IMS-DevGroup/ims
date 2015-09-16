class DeviceGroupsController < ApplicationController
  before_action :set_device_group, only: [:show, :edit, :update, :destroy]

  # GET /device_groups
  # GET /device_groups.json
  def index
    @device_groups = DeviceGroup.all
  end

  # GET /device_groups/1
  # GET /device_groups/1.json
  def show
  end

  # GET /device_groups/new
  def new
    if current_user.right.manage_devices == false
      redirect_to '/device_groups/'
    elsif BossConfig.first.db_state == false
      flash[:error] = 'Datenbank Status: Im Einsatz, keine keine Änderung mölgich'
      redirect_to "/device_groups/"
    else
    @device_group = DeviceGroup.new
    end
  end
  # GET /device_groups/1/edit
  def edit
    if current_user.right.manage_devices == false
      redirect_to '/device_groups/'
    elsif BossConfig.first.db_state == false
      flash[:error] = 'Datenbank Status: Im Einsatz, keine keine Änderung mölgich'
      redirect_to "/device_groups/"
    end
  end

  # POST /device_groups
  # POST /device_groups.json
  def create
    @device_group = DeviceGroup.new(device_group_params)

    respond_to do |format|
      if @device_group.save
        flash[:success] = (I18n.t "own.success.device_group_created").to_s
        format.html { redirect_to @device_group }
        format.json { render :show, status: :created, location: @device_group }
      else
        format.html { render :new }
        format.json { render json: @device_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /device_groups/1
  # PATCH/PUT /device_groups/1.json
  def update
    respond_to do |format|
      if @device_group.update(device_group_params)
        flash[:success] = (I18n.t "own.success.device_group_updated").to_s
        format.html { redirect_to @device_group }
        format.json { render :show, status: :ok, location: @device_group }
      else
        format.html { render :edit }
        format.json { render json: @device_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /device_groups/1
  # DELETE /device_groups/1.json
  def destroy
    if BossConfig.first.db_state == false
    flash[:error] = 'Datenbank Status: Im Einsatz, keine keine Änderung mölgich'
    redirect_to "/device_groups/"
    else
    @device_group.destroy
    respond_to do |format|
      flash[:success] = (I18n.t "own.success.device_type_destroyed").to_s
      format.html { redirect_to @device_group }
      format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_device_group
      @device_group = DeviceGroup.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def device_group_params
      params.require(:device_group).permit(:name, :info)
    end
end
