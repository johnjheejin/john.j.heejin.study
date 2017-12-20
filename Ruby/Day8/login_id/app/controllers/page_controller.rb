class PageController < ApplicationController
  def index
  end

  def login
  end

  def join
    @account = params[:account]
    @password = params[:password]
  end

  def login_process
  end

  def logout
  end

  def join_process
  end
end
