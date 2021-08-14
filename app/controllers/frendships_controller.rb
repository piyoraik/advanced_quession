class FrendshipsController < ApplicationController
  before_action :set_user, only: %i[create destroy follower followed]
  before_action :set_book, only: %i[follower followed]

  def create
    current_user.follow(@user.id)
    redirect_to user_path(@user.id)
  end

  def destroy
    current_user.unfollow(@user.id)
    redirect_to user_path(@user.id)
  end

  def follower; end

  def followed; end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def set_book
    @book = Book.new
  end
end
