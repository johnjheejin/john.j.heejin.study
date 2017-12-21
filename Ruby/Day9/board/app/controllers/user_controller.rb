class UserController < ApplicationController
  def new
  end

  def create
    @email = params[:email]
    @password = params[:password]
    User.create(
      email: @email,
      password: @password
      )
  end

  def login
  end

  def login_process
    @email = params[:email]
    @password = params[:password]

    user = User.find_by(email: @email)

    if User.exists?(email: @email)
      if user.password == @password
        session[:user_id] = user.id
        # 로그인을 할 때 session[:user_id] 는 
        # user데이터 베이스에 저장된 고유 id값을 말한다.
        flash[:notice] = "Welcome Again!"
        redirect_to '/'
      else
        flash[:notice] = "Incorrect Password"
        redirect_to '/user/login'
      end
    else
      flash[:notice] = "No such Account"
      redirect_to '/user/login'
    end


  end

  def logout
    flash[:notice] = "Seeya!"
    session.clear
  end
end
