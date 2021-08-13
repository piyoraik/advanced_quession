class UsersController < ApplicationController
	before_action :authenticate_user!
	before_action :set_user, only: [:edit, :update, :show]
	before_action :set_users, only: [:index]
	before_action :edit_auth, only: [:edit, :update]

	def index
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
	def set_users
		@users = User.all
	end

	def set_user
		@user = User.find(params[:id])
	end

	def user_params
		params.require(:user).permit(:name, :introduction, :image)
	end

	def edit_auth
		unless current_user.id == params[:id]
			redirect_to user_path(params[:id])
		end
	end
end
