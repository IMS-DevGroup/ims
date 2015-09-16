class StocksController < ApplicationController
  before_action :set_stock, only: [:show, :edit, :update, :destroy]

  # GET /stocks
  # GET /stocks.json
  def index
    @stocks = Stock.all
  end

  # GET /stocks/1
  # GET /stocks/1.json
  def show
  end

  # GET /stocks/new
  def new
    if BossConfig.first.db_state == false
      flash[:error] = 'Datenbank Status: Im Einsatz, keine keine Änderung mölgich'
      redirect_to "/stocks/"
    elsif current_user.right.manage_stocks_and_units == false
      redirect_to '/stocks/'
      else
    @stock = Stock.new
  end
end
  # GET /stocks/1/edit
  def edit
    if BossConfig.first.db_state == false
      flash[:error] = 'Datenbank Status: Im Einsatz, keine keine Änderung mölgich'
      redirect_to "/stocks/"
    elsif current_user.right.manage_stocks_and_units == false
      redirect_to '/stocks/'
  end
  end

  # POST /stocks
  # POST /stocks.json
  def create
    if BossConfig.first.db_state == false
      flash[:error] = 'Datenbank Status: Im Einsatz, keine keine Änderung mölgich'
      redirect_to "/stocks/"
    else
    @stock = Stock.new(stock_params)

    respond_to do |format|
      if @stock.save
        flash[:success] = (I18n.t "own.success.stock_created").to_s
        format.html { redirect_to @stock }
        format.json { render :show, status: :created, location: @stock }

      else
        #get all error messages and save it into a string
        flash.now[:error] = (@stock.errors.values).join("<br/>").html_safe
        format.html { render :new }
        format.json { render json: @stock.errors, status: :unprocessable_entity }
      end
    end

  end
end
  # PATCH/PUT /stocks/1
  # PATCH/PUT /stocks/1.json
  def update
    if BossConfig.first.db_state == false
      flash[:error] = 'Datenbank Status: Im Einsatz, keine keine Änderung mölgich'
      redirect_to "/stocks/"
    else
    respond_to do |format|
      if @stock.update(stock_params)
        flash[:success] = (I18n.t "own.success.stock_updated").to_s
        format.html { redirect_to @stock }
        format.json { render :show, status: :ok, location: @stock }
      else
        #get all error messages and save it into a string
        flash.now[:error] = (@stock.errors.values).join("<br/>").html_safe
        format.html { render :edit }
        format.json { render json: @stock.errors, status: :unprocessable_entity }
      end
    end
  end
end
  # DELETE /stocks/1
  # DELETE /stocks/1.json
  def destroy
    if BossConfig.first.db_state == false
      flash[:error] = 'Datenbank Status: Im Einsatz, keine keine Änderung mölgich'
      redirect_to "/stocks/"
    else

    @stock.destroy
    respond_to do |format|
      flash[:success] = (I18n.t "own.success.stock_destroyed").to_s
      format.html { redirect_to @stock }
      format.json { head :no_content }
    end
  end
end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_stock
      @stock = Stock.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def stock_params
      params.require(:stock).permit(:name, :info, :unit_id, :city, :street)
    end
end