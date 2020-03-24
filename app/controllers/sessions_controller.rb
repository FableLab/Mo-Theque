class SessionsController < ApplicationController
  def destroy
    logout if logged_in?
    redirect_to root_path
  end
end
