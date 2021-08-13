class UsersController < ApplicationController
	before_action :authenticate_user!
	before_action :set_user, only: [:edit, :update, :show]
	before_action :edit_auth, only: [:edit, :update]

	def index
		@users = User.all
	end

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

	def edit_auth
		unless current_user.id == @user.id
			redirect_to user_path(@user.id)
		end
	end
end
