class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all.eager_load(:unit).order(:lastname)
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    if current_user.right.manage_users == false
      redirect_to '/users/'
    else
      @user = User.new
    end
  end

  # GET /users/1/edit
  def edit
    if current_user.right.manage_users == false
      redirect_to '/users/'
    end
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save

        if !@user.email.nil? && @user.password == nil && @user.username != nil
          @user.activate
          #@user.create_activation_key
          #@user.send_activation_email
          #methodn aufruf
          flash[:warning] = 'Please check your email to activate your account.' #auskommentieren!
        end

        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        #get all error messages and save it into a string
        flash.now[:error] = (@user.errors.full_messages).join("<br/>").html_safe
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        #get all error messages and save it into a string
        flash.now[:error] = (@user.errors.full_messages).join("<br/>").html_safe
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def test_test
  end
  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      flash[:success] = (I18n.t "own.success.user_destroyed").to_s
      format.html { redirect_to @user }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:username, :password, :active, :email, :prename, :lastname, :mobile_number, :info,
                                 :unit_id, :right_id, :password_unhashed, :password_unhashed_confirmation)
  end
end
