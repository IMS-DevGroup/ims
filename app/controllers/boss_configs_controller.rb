class BossConfigsController < ApplicationController
  before_action :set_boss_config, only: [:show, :edit, :update, :destroy]

  # GET /boss_configs
  # GET /boss_configs.json
  def index
    if current_user.right.manage_boss == false
      redirect_to "/starts"
    else
    redirect_to "/boss_configs/1"
    #@boss_configs = BossConfig.all
  end
    end

  # GET /boss_configs/1
  # GET /boss_configs/1.json
  def show
    if current_user.right.manage_boss == false
      redirect_to "/starts"
    end
  end

  # GET /boss_configs/new
  def new
    if current_user.right.manage_boss == false
      redirect_to "/starts"
    else
    redirect_to "/boss_configs/1"
   #@boss_config = BossConfig.new
  end
  end

  # GET /boss_configs/1/edit
  def edit
    if current_user.right.manage_boss == false
       redirect_to "/starts"
    end
  end

  # POST /boss_configs
  # POST /boss_configs.json
  def create
    if BossConfig.first.nil?
    @boss_config = BossConfig.new(boss_config_params)

    respond_to do |format|
      if @boss_config.save
        format.html { redirect_to @boss_config, notice: 'Boss config was successfully created.' }
        format.json { render :show, status: :created, location: @boss_config }
      else
        format.html { render :new }
        format.json { render json: @boss_config.errors, status: :unprocessable_entity }
      end
    end
      end
  end

  # PATCH/PUT /boss_configs/1
  # PATCH/PUT /boss_configs/1.json
  def update
    respond_to do |format|
      if @boss_config.update(boss_config_params)
        flash[:success] = (I18n.t "own.success.boss_config_updated").to_s
        format.html { redirect_to @boss_config }
        format.json { render :show, status: :ok, location: @boss_config }
      else
        format.html { render :edit }
        format.json { render json: @boss_config.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /boss_configs/1
  # DELETE /boss_configs/1.json
  def destroy
    @boss_config.destroy
    respond_to do |format|
      format.html { redirect_to boss_configs_url, notice: 'Boss config was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_boss_config
      @boss_config = BossConfig.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def boss_config_params
      params.require(:boss_config).permit(:db_state, :org_name)
    end
end
