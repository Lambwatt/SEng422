class UsersController < ApplicationController
	load_and_authorize_resource

	def index
	end

	def new
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])

		# pretty sure there's a better way to do this
		@user.username = params[:user][:username]
		@user.password = params[:user][:password]
		@user.roles = params[:user][:role_ids].select {|s| s.length > 0}.map {|s| Role.find_by_id s.to_i}

		if @user.save
			redirect_to users_path
		else
			render :edit
		end

	end

	def create
		if @user.save
			redirect_to users_path, notice: 'User was successfully created.'
		else
			render action: 'new'
		end
	end
end
