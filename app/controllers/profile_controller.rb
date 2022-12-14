class ProfileController < ApplicationController
  before_action :require_login
  before_action :set_profile, except: :destroy
  before_action :redirect_if_empty, except: :destroy

  def show
    @authors = Author.where(user: @user)
    if @authors.present?
      @authors = @authors.includes(:user, :music)
    end
  end

  def edit
  end

  def update
    redirect_to root_path, status: :unprocessable_entity if @user != current_user
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
      permit(:name, :artistic_name, :email, :password)
  end
end
