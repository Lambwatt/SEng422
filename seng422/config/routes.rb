Seng422::Application.routes.draw do
	devise_for :users,
		:skip => [:registrations], # preventing user registration here.
		:path => "",
		:path_names => {:sign_in => "login", :sign_out => "logout"}

	resources :todo_lists

	get "welcome/index"
	root to: "welcome#index"
end
