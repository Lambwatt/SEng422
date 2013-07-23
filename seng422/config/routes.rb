Seng422::Application.routes.draw do
	resources :checklists do
		resources :items
	end

	resources :users do
		member do
			get :edit_roles
			put :update_roles
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
