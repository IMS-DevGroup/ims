class ValuesController < ApplicationController
  before_action :set_value, only: [:show, :edit, :update, :destroy]

  # GET /values
  # GET /values.json
  def index
   #redirect_to '/starts/'
   # this reactivates the link to /values
   @values = Value.all
  end

  # GET /values/1
  # GET /values/1.json
  def show
    # delete the following to reactivate link
    redirect_to '/starts/'
  end

  # GET /values/new
  def new
    redirect_to '/starts/'
    # this reactivates the link to /values/new
    # @value = Value.new
  end

  # GET /values/1/edit
  def edit
  end

  # POST /values
  # POST /values.json
  def create
    @value = Value.new(value_params)

    respond_to do |format|
      if @value.save
        format.html { redirect_to @value, notice: 'Value was successfully created.' }
        format.json { render :show, status: :created, location: @value }
      else
        format.html { render :new }
        format.json { render json: @value.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /values/1
  # PATCH/PUT /values/1.json
  def update
    respond_to do |format|
      if @value.update(value_params)
        format.html { redirect_to @value, notice: 'Value was successfully updated.' }
        format.json { render :show, status: :ok, location: @value }
      else
        format.html { render :edit }
        format.json { render json: @value.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /values/1
  # DELETE /values/1.json
  def destroy
    @value.destroy
    respond_to do |format|
      format.html { redirect_to values_url, notice: 'Value was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def ValuesController.insert(prop_val, prop_id, device)
    if !prop_val.nil?
      prop_val.each do |key, val|
        v = Value.new
        v.property_id = prop_id[key]
        v.value = prop_val[key]
        v.device_id = device.id
        v.save
      end
    end
  end

  def ValuesController.change(prop_val, prop_id, device)
    if !prop_val.nil?
      prop_val.each do |key, val|
        prop = Property.find_by_id(prop_id[key])
        v = prop.values.find_by_device_id(device.id)
        v.value = prop_val[key]
        v.save
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_value
      @value = Value.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def value_params
      params.require(:value).permit(:value, :property_id, :device_id)
    end
end
