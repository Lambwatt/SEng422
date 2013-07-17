class UsersController < ApplicationController
	load_and_authorize_resource

	def index
	end

	def new
	end

	def create
		if @user.save
			redirect_to users_path, notice: 'User was successfully created.'
		else
			render action: 'new'
		end
	end
end
