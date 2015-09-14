class RightsController < ApplicationController
  before_action :set_right, only: [:show, :edit, :update, :destroy]

  # GET /rights
  # GET /rights.json
  def index
    if current_user.right.manage_rights == true
      redirect_to '/rights/'
    else
    redirect_to '/starts/'
    end
  end

  # GET /rights/1
  # GET /rights/1.json
  def show
    if current_user.right.manage_rights == false
      redirect_to '/starts/'
    end
  end

  # GET /rights/new
  def new
    if current_user.right.manage_rights == false
      redirect_to '/starts/'
    else
    @right = Right.new
  end
end
  # GET /rights/1/edit
  def edit
    if current_user.right.manage_rights == false
      redirect_to '/starts/'
      end
  end

  # POST /rights
  # POST /rights.json
  def create
    @right = Right.new(right_params)

    respond_to do |format|
      if @right.save
        format.html { redirect_to @right, notice: 'Right was successfully created.' }
        format.json { render :show, status: :created, location: @right }
      else
        format.html { render :new }
        format.json { render json: @right.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rights/1
  # PATCH/PUT /rights/1.json
  def update
    respond_to do |format|
      if @right.update(right_params)
        flash[:success] = (I18n.t "own.success.right_updated").to_s
        format.html { redirect_to (request.env["HTTP_REFERER"]) }
        format.json { render :show, status: :ok, location: @right }
      else
        format.html { render :edit }
        format.json { render json: @right.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rights/1
  # DELETE /rights/1.json
  def destroy
    @right.destroy
    respond_to do |format|
      format.html { redirect_to rights_url, notice: 'Right was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_right
      @right = Right.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def right_params
      params.require(:right).permit(:manage_rights, :manage_users, :manage_devices, :manage_device_types, :manage_stocks_and_units, :manage_operations, )
    end
end
