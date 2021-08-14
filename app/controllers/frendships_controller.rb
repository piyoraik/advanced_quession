class FrendshipsController < ApplicationController
	before_action :set_user, only: %i[create destroy]

	def create
		follower = current_user.follow(@user.id)
		redirect_to user_path(@user.id)
	end

	def destroy
	end

	private

	def set_user
		@user = User.find(params[:user_id])
	end
end
