module SessionsHelper

    def signed_in_user
      unless logged_in?
        store_location
        redirect_to new_sessions_path
      end
    end

    def redirect_back_or(default)
      redirect_to(session[:return_to] || default)
      session.delete(:return_to)
    end

    def store_location
      session[:return_to] = request.url if request.get?
    end
end
