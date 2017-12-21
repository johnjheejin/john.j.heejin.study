class PageController < ApplicationController
  def index
  end

  def login
  end

  def join
    require 'digest'
  end

  def login_process
    @account = params[:account]
    @password = params[:password]

    md5_password = Digest::MD5.hexdigest(@password)

    user = Account.find_by(account: @account)

    if Account.exists?(account: @account)
      if user.password == md5_password
        session[:user_id] = user.account
      end
    end
  end

  def logout
    session.clear
  end

  def join_process
    @account = params[:account]
    @password = params[:password]

    md5_password = Digest::MD5.hexdigest(@password)

    Account.create(
      account: @account,
      password: md5_password
      )
  end
end
