class HomeController < ApplicationController
  # 
  def index

  end
  # 
  def welcome
  	@user = params[:user]
  	# user라는 이름으로 넘어온 parameter를 @user로 정의한다.
  end
  #
end
