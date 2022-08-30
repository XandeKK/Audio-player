class ProfileController < ApplicationController
  before_action :require_login
  before_action :set_profile, except: :destroy
  before_action :redirect_if_empty, except: :destroy

  def show
  end

  def edit
  end

  def update
    if @user.update(profile_params)
      redirect_to profile_path(@user)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if current_user.destroy
      redirect_to sign_up_path
    else
      redirect_to profile_path(current_user), status: :unprocessable_entity
    end
  end

  private

  def set_profile
    @user = User.find_by(id: params[:id])
  end

  def redirect_if_empty
    redirect_to root_path if @user.nil?
  end

  def profile_params
    params.require(:user).
      permit(:name, :artistic_name, :email, :password).
      delete_if {|key, value| value.blank? }
  end
end
