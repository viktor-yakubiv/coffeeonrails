class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]
  skip_before_action :require_admin, only: [:new, :create, :destroy]

  def new
  end

  def create
    puts params
    puts params[:password]
    user = User.authenticate(params[:username], params[:password])
    if user
      session[:user_id] = user.id
      redirect_to root_url, :notice => t('notice.logged_in')
    else
      flash.now.alert = t('notice.wrong_credentials')
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => t('notice.logged_out')
  end
end
