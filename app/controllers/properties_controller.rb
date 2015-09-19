class PropertiesController < ApplicationController
  before_action :set_property, only: [:show, :edit, :update, :destroy]

  # GET /properties
  # GET /properties.json
  def index
    @properties = Property.all
  end

  # GET /properties/1
  # GET /properties/1.json
  def show
  end

  # GET /properties/new
  def new
    if BossConfig.first.db_state == false
      flash[:error] = (I18n.t "own.errors.db_offline").to_s
      redirect_to "/properties/"
    else
      @property = Property.new
    end
  end

  # GET /properties/1/edit
  def edit
    if BossConfig.first.db_state == false
      flash[:error] = (I18n.t "own.errors.db_offline").to_s
      redirect_to "/properties/"
    end
  end

  # POST /properties
  # POST /properties.json
  def create
    if BossConfig.first.db_state == false
      flash[:error] = (I18n.t "own.errors.db_offline").to_s
      redirect_to "/properties/"
    elsif BossConfig.first.db_state == false  ###useless, da doppelt #TODO
      flash[:error] = (I18n.t "own.errors.db_offline").to_s
      redirect_to "/properties/"
    else
      @property = Property.new(property_params)

      respond_to do |format|
        if @property.save
          flash[:success] = (I18n.t "own.success.property_created").to_s
          format.html { redirect_to @property }
          format.json { render :show, status: :created, location: @property }
        else
          format.html { render :new }
          format.json { render json: @property.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /properties/1
  # PATCH/PUT /properties/1.json
  def update
    if BossConfig.first.db_state == false
      flash[:error] = (I18n.t "own.errors.db_offline").to_s
      redirect_to "/units/"
    else
      respond_to do |format|
        if @property.update(property_params)
          flash[:success] = (I18n.t "own.success.property_updated").to_s
          format.html { redirect_to @property }
          format.json { render :show, status: :ok, location: @property }
        else
          format.html { render :edit }
          format.json { render json: @property.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /properties/1
  # DELETE /properties/1.json
  def destroy
    if BossConfig.first.db_state == false
      flash[:error] = (I18n.t "own.errors.db_offline").to_s
      redirect_to "/units/"
    else
      @property.destroy
      respond_to do |format|
        flash[:success] = (I18n.t "own.success.property_destroyed").to_s
        format.html { redirect_to @property }
        format.json { head :no_content }
      end
    end
  end

  def get_data_type_name
    return @property.data_type.name
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_property
    @property = Property.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def property_params
    params.require(:property).permit(:name, :info, :data_type_id, :device_type_id)
  end
end
