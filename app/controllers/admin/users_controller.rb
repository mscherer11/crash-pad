class Admin::UsersController < Admin::BaseController
  def index
    @users = User.unscoped.all
  end

  def show
    @user = User.unscoped.find(params[:id])
  end

  def edit
    @user = User.unscoped.find(params[:id])
  end

  def update
    @user = User.unscoped.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "Account successfully updated!"
      redirect_to admin_user_path(@user)
    else
      redirect_to edit_admin_user_path(@user)
    end
  end

  private

  def user_params
    params.require(:user).permit(:id, :email, :password, :first_name, :last_name, :phone, :avatar_url, :status)
  end
end
