Seng422::Application.routes.draw do
	resources :checklists do
		resources :items

		member do
			get :fill_out
		end

		collection do
			get :for_current_user
		end
	end

	resources :users do
		member do
			get :edit_roles
			put :update_roles
			get :edit_username
			put :update_username
			get :reset_password
			put :update_password
		end
	end


	devise_for :users,
		:skip => [:registrations], # preventing user registration here.
		:path => "",
		:path_names => {:sign_in => "login", :sign_out => "logout"}

	resources :todo_lists

	get "welcome/index"
	root to: "welcome#index"
end
