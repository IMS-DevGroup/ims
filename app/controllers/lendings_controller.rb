class LendingsController < ApplicationController
  before_action :set_lending, only: [:show, :edit, :update, :destroy]
  # Global list of devices that were already selected to be borrowed in this session
  # Currently disabled remainder of first try of multiple-device-lending
  # @@global_list = []


  # GET /lendings
  # GET /lendings.json
  def index
    @lendings = Lending.all
  end

  # GET /lendings/1
  # GET /lendings/1.json
  def show
  end

  # GET /lendings/new
  def new
    @lending = Lending.new
    #local parameter list is needed for device_list partial
    # Currently disabled remainder of first try of multiple-device-lending
    # @list = @@global_list
  end

  # GET /lendings/1/edit
  def edit
  end


  # POST /lendings
  # POST /lendings.json
  def create

    @lending = Lending.new(lending_params)

    respond_to do |format|

=begin
  # Currently disabled remainder of first try of multiple-device-lending
      # adding more devices, currently old device is filled in by default
      if params[:commit].eql?("add")
        @@global_list << lending_params
        @list = @@global_list
        format.html { render :new }

      # saving the objects from the list (caution currently no error handling!)
      else
        @@global_list.each do |len_params|
          @lending = Lending.new(len_params)
          if @lending.save
            puts("success")
          else
            puts("failure")
          end
        end
        #reset global list to empty
        @@global_list = []
        format.html {redirect_to :back}
      end
=end


     # original code
       if @lending.save
         format.html { redirect_to @lending, notice: 'Lending was successfully created.' }
         format.json { render :show, status: :created, location: @lending }
       else
         format.html { render :new }
         format.json { render json: @lending.errors, status: :unprocessable_entity }
       end
      end
  end

  # PATCH/PUT /lendings/1
  # PATCH/PUT /lendings/1.json
  def update
    respond_to do |format|
      if @lending.update(lending_params)
        format.html { redirect_to @lending, notice: 'Lending was successfully updated.' }
        format.json { render :show, status: :ok, location: @lending }
      else
        format.html { render :edit }
        format.json { render json: @lending.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lendings/1
  # DELETE /lendings/1.json
  def destroy
    @lending.destroy
    respond_to do |format|
      format.html { redirect_to lendings_url, notice: 'Lending was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # Currently disabled remainder of first try of multiple-device-lending
  # def delete_from_list
  #   puts params
  #   redirect_to action: :new
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lending
      @lending = Lending.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def lending_params
      params.require(:lending).permit(:receive, :lending_info, :receive_info, :user_id, :device_id, :lender_id)
    end
end
