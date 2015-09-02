require 'barby'
require 'barby/barcode/code_128'
require 'barby/outputter/png_outputter'

class BarcodeTestsController < ApplicationController
  before_action :set_barcode_test, only: [:show, :edit, :update, :destroy]



  # GET /barcode_tests
  # GET /barcode_tests.json
  def index
    @prodid = '00000002'
    @barcode = Barby::Code128B.new(@prodid)
    if(!File.exist?('public/barcodes/'+@prodid+'.png'))
      File.open('public/barcodes/'+@prodid+'.png', 'w'){|f|
        f.write @barcode.to_png(:height => 60, :margin => 5)
      }
    end
    remove_old_barcodes
  end

  #deletes barcodes which are older 0.03days
  def remove_old_barcodes
    Dir.foreach('public/barcodes') do |filename|
      next if filename == '.' or filename == '..'
      time = (Time.now - File.stat('public/barcodes/'+filename).mtime).to_i / 86400.0
      if(time>0.03)
        File.delete('public/barcodes/'+filename)
      end
    end
  end

  # GET /barcode_tests/1
  # GET /barcode_tests/1.json
  def show
  end


  # GET /barcode_tests/new
  def new
    @barcode_test = BarcodeTest.new
  end

  # GET /barcode_tests/1/edit
  def edit
  end

  # POST /barcode_tests
  # POST /barcode_tests.json
  def create
    @barcode_test = BarcodeTest.new(barcode_test_params)

    respond_to do |format|
      if @barcode_test.save
        format.html { redirect_to @barcode_test, notice: 'Barcode test was successfully created.' }
        format.json { render :show, status: :created, location: @barcode_test }
      else
        format.html { render :new }
        format.json { render json: @barcode_test.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /barcode_tests/1
  # PATCH/PUT /barcode_tests/1.json
  def update
    respond_to do |format|
      if @barcode_test.update(barcode_test_params)
        format.html { redirect_to @barcode_test, notice: 'Barcode test was successfully updated.' }
        format.json { render :show, status: :ok, location: @barcode_test }
      else
        format.html { render :edit }
        format.json { render json: @barcode_test.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /barcode_tests/1
  # DELETE /barcode_tests/1.json
  def destroy
    @barcode_test.destroy
    respond_to do |format|
      format.html { redirect_to barcode_tests_url, notice: 'Barcode test was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_barcode_test
      @barcode_test = BarcodeTest.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def barcode_test_params
      params.require(:barcode_test).permit(:device_id)
    end
end
