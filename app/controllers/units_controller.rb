class UnitsController < ApplicationController
  before_action :set_unit, only: [:show, :edit, :update, :destroy]

  # GET /units
  # GET /units.json
  def index
    @units = Unit.all
  end

  # GET /units/1
  # GET /units/1.json
  def show
  end

  # GET /units/new
  def new
    if BossConfig.first.db_state == false
      flash[:error] = 'Datenbank Status: Im Einsatz, keine keine Änderung mölgich'
      redirect_to "/units/"
    elsif current_user.right.manage_stocks_and_units == false
      redirect_to '/units/'
    else
    @unit = Unit.new
      end
  end

  # GET /units/1/edit
  def edit
    if BossConfig.first.db_state == false
      flash[:error] = 'Datenbank Status: Im Einsatz, keine keine Änderung mölgich'
      redirect_to "/units/"
    elsif current_user.right.manage_stocks_and_units == false
      redirect_to '/units/'
    end
  end

  # POST /units
  # POST /units.json
  def create
    if BossConfig.first.db_state == false
               flash[:error] = 'Datenbank Status: Im Einsatz, keine keine Änderung mölgich'
               redirect_to "/units/"
             else
    @unit = Unit.new(unit_params)

    respond_to do |format|
      if @unit.save
        flash[:success] = (I18n.t "own.success.unit_updated").to_s
        format.html { redirect_to @unit }
        format.json { render :show, status: :created, location: @unit }
      else
        #get all error messages and save it into a string
        flash.now[:error] = (@unit.errors.values).join("<br/>").html_safe
        format.html { render :new }
        format.json { render json: @unit.errors, status: :unprocessable_entity }
      end
    end
  end
end
  # PATCH/PUT /units/1
  # PATCH/PUT /units/1.json
  def update
    if BossConfig.first.db_state == false
      flash[:error] = 'Datenbank Status: Im Einsatz, keine keine Änderung mölgich'
      redirect_to "/units/"
    else
    respond_to do |format|
      if @unit.update(unit_params)
        flash[:success] = (I18n.t "own.success.unit_updated").to_s
        format.html { redirect_to @unit }
        format.json { render :show, status: :ok, location: @unit }
      else
        #get all error messages and save it into a string
        flash.now[:error] = (@unit.errors.values).join("<br/>").html_safe
        format.html { render :edit }
        format.json { render json: @unit.errors, status: :unprocessable_entity }
      end
    end
  end
end
  # DELETE /units/1
  # DELETE /units/1.json
  def destroy
    if BossConfig.first.db_state == false
      flash[:error] = 'Datenbank Status: Im Einsatz, keine keine Änderung mölgich'
      redirect_to "/units/"
    else
    @unit.destroy
    respond_to do |format|
      flash[:success] = (I18n.t "own.success.unit_destroyed").to_s
      format.html { redirect_to @unit }
      format.json { head :no_content }
    end
  end
end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_unit
      @unit = Unit.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def unit_params
      params.require(:unit).permit(:name, :info, :phone_number)
    end
end
