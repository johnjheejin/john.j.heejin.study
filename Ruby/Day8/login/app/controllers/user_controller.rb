class UserController < ApplicationController
  def index
  	if session[:user_id]
  		@email = User.find(session[:user_id]).email
  	end
  end
  def new
  	
  end
  def login
  	
  end
  def create
  	require "digest"

  	@email = params[:email]
  	@password = params[:password]

  	md5_password = Digest::MD5.hexdigest(@password)

  	User.create(
  		email: @email,
  		password: md5_password
  		)

  	redirect_to '/'
  	end

  	def login_process
  		@email = params[:email]
  		@password = params[:password]

  		md5_password = Digest::MD5.hexdigest(@password)

  		user = User.find_by(email: @email)

		if User.exists?(email: @email)
			if user.password == md5_password
				session[:user_id] = user.id
				redirect_to '/'
			end
		end
  	end

  	def logout
  		session.clear
  		redirect_to '/'
  	end

end
