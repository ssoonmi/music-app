class SessionsController < ApplicationController
  before_action :ensure_logged_in, only: [:destroy]
  before_action :ensure_not_logged_in, only: [:new, :create]

  def new
    render :new
  end

  def create
    user = User.find_by_credentials(session_params)
    if user
      log_in!(user)
      redirect_to bands_url
    else
      flash[:errors] = ['Invalid email or password']
      redirect_to new_session_url
    end
  end

  def destroy
    log_out!(current_user)
    redirect_to new_session_url
  end

  private

  def session_params
    params.require(:user).permit(:email, :password)
  end

end
