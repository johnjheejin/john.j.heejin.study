class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
  	@user ||= User.find(session[:user_id]) if User.exists? && session[:user_id]
  		#유저 데이터에도 있고, 세션아이디도 있으면
  end

  helper_method :current_user

  def authenticate_user
 	unless current_user
 		flash[:notice] = "Need to Login"
 		redirect_to '/user/login'
 	end
  end

end
