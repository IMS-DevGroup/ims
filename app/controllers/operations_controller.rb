class OperationsController < ApplicationController
  before_action :set_operation, only: [:show, :edit, :update, :destroy]

  # GET /operations
  # GET /operations.json
  def index
    @operations = Operation.all
  end

  # GET /operations/1
  # GET /operations/1.json
  def show
  end

  # GET /operations/new
  def new
    if current_user.right.manage_operations == false
      redirect_to "/operations"
    elsif BossConfig.first.db_state == false
      redirect_to "/operations"
      flash[:error] = (I18n.t "own.errors.db_offline").to_s
    else
    @operation = Operation.new
  end
end
  # GET /operations/1/edit
  def edit
    if current_user.right.manage_operations == false
      redirect_to "/operations"
    elsif BossConfig.first.db_state == false
      redirect_to "/operations"
      flash[:error] = (I18n.t "own.errors.db_offline").to_s
  end
  end

  # POST /operations
  # POST /operations.json
  def create
    @operation = Operation.new(operation_params)
    respond_to do |format|
      if @operation.save
        flash[:success] = (I18n.t "own.success.operation_created").to_s
        format.html { redirect_to @operation }
        format.json { render :show, status: :created, location: @operation }
      else
        #get all error messages and save it into a string
        flash.now[:error] = (@operation.errors.values).join("<br/>").html_safe
        format.html { render :new }
        format.json { render json: @operation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /operations/1
  # PATCH/PUT /operations/1.json
  def update
    respond_to do |format|
      if @operation.update(operation_params)
        flash[:success] = (I18n.t "own.success.operation_updated").to_s
        format.html { redirect_to @operation }
        format.json { render :show, status: :ok, location: @operation }
      else
        #get all error messages and save it into a string
        flash.now[:error] = (@operation.errors.values).join("<br/>").html_safe
        format.html { render :edit }
        format.json { render json: @operation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /operations/1
  # DELETE /operations/1.json
  def destroy
    if BossConfig.first.db_state == false
      redirect_to "/operations"
      flash[:error] = (I18n.t "own.errors.db_offline").to_s
    else
    @operation.destroy
    respond_to do |format|
      flash[:success] = (I18n.t "own.success.operation_destroyed").to_s
      format.html { redirect_to @operation }
      format.json { head :no_content }
      end
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_operation
    @operation = Operation.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def operation_params
    params.require(:operation).permit(:number, :operation_type, :info, :location, :close_date, :user_id, :stock_ids => [])
  end


  def show_lendings
  end

end
