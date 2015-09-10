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
    @stock = Stock.new
  end

  # GET /stocks/1/edit
  def edit
  end

  # POST /stocks
  # POST /stocks.json
  def create
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

  # PATCH/PUT /stocks/1
  # PATCH/PUT /stocks/1.json
  def update
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

  # DELETE /stocks/1
  # DELETE /stocks/1.json
  def destroy

    @stock.destroy
    respond_to do |format|
      format.html { redirect_to stocks_url, notice: 'Stock was successfully destroyed.' }
      format.json { head :no_content }
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
