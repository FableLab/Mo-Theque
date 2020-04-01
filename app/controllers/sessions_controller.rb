class SessionsController < ApplicationController
  def destroy
    logout if logged_in?
    redirect_to root_path
  end

  def new
    @user = User.new
  end

  def create
    if @user = login(session_params[:email].downcase, session_params[:password])
      redirect_back_or root_path
    else
      redirect_to new_sessions_path(invalid_session_params: :true)
    end
  end

  private

  def session_params
    params.require(:user).permit(:email, :password, :invalid_session_params)
  end
end
