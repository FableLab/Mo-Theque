class UsersController < ApplicationController
  def new
    redirect_to root_path if current_user
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login(@user.email, user_params[:password])
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    unless @user = User.find(params[:id])
      raise ActionController::RoutingError.new('Not Found')
    end
  end

  private

  def user_params
    params.require(:user).permit(:user_name, :first_name, :last_name,
                                 :email, :password, :password_confirmation)
  end
end
