class UsersController < ApplicationController
  before_action :signed_in_user, only: [:edit, :update]
  
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

  def edit
  end

  def update
    if current_user.update_attributes(user_params)
      redirect_to current_user
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:user_name, :first_name, :last_name, :email,
                                 :description, :password, :password_confirmation)
  end
end
