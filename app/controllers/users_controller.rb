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
    elsif BossConfig.first.db_state == false
      flash[:error] = (I18n.t "own.errors.db_offline").to_s
      redirect_to "/users/"
    else

      @user = User.new
    end
  end

  # GET /users/1/edit
  def edit
    if current_user.right.manage_users == false
      redirect_to '/users/'

    elsif BossConfig.first.db_state == false
      flash[:error] = (I18n.t "own.errors.db_offline").to_s
      redirect_to "/users/"
    end
  end

  # POST /users
  # POST /users.json
  def create

    @user = User.new(user_params)
    if BossConfig.first.db_state == false
      flash[:error] = (I18n.t "own.errors.db_offline").to_s
      redirect_to "/users/"
    else
    respond_to do |format|
      if @user.save

        # When a user with email but without pw is generated, user.activate is called
        # which does generate and send a random pw to the user
        if !@user.email.nil? && @user.password.nil? && @user.username != nil
          @user.activate
          flash[:warning] = (I18n.t "own.warning.user_without_pw").to_s
        end

        flash[:success] = (I18n.t "own.success.user_created").to_s
        format.html { redirect_to @user }
        format.json { render :show, status: :created, location: @user }
      else
        #get all error messages and save it into a string
        flash.now[:error] = (@user.errors.values).join("<br/>").html_safe
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
end
  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    if BossConfig.first.db_state == false
      flash[:error] = (I18n.t "own.errors.db_offline").to_s
      redirect_to "/users/"
    else

    respond_to do |format|
      if @user.update(user_params)
        flash[:success] = (I18n.t "own.success.user_updated").to_s
        if params[:commit] == (t 'buttons.start.set_stock')
          format.html { redirect_to starts_url  }
        else
          format.html { redirect_to @user }
          format.json { render :show, status: :ok, location: @user }
        end
      else
        #get all error messages and save it into a string
        flash.now[:error] = (@user.errors.values).join("<br/>").html_safe
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    if BossConfig.first.db_state == false
    flash[:error] = (I18n.t "own.errors.db_offline").to_s
    redirect_to "/users/"
  else
    @user.destroy
    respond_to do |format|
      flash[:success] = (I18n.t "own.success.user_destroyed").to_s
      format.html { redirect_to @user }
      format.json { head :no_content }
    end
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
                                 :unit_id, :right_id, :password_unhashed, :password_unhashed_confirmation, :stock_id, :language)
  end

end


