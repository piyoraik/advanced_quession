# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: %i[edit update show]
  before_action :edit_auth, only: %i[edit update]

  def index
    @users = User.with_attached_image
  end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  def show; end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :introduction, :image)
  end

  def edit_auth
    redirect_to user_path(@user.id) unless current_user.id == @user.id
  end
end
