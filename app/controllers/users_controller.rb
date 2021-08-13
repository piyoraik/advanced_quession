class UsersController < ApplicationController
	before_action :set_user, only: [:edit, :update, :show]
	def edit
	end

	def update
		if @user.update(user_params)
			redirect_to user_path(@user.id)
		else
			render :edit
		end
	end

	def show
	end

	private
	def set_user
		@user = User.find(params[:id])
	end

	def user_params
		params.require(:user).permit(:name, :introduction, :image)
	end
end
