Rails.application.routes.draw do


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :ideas
  resource :session, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create]


  root 'welcome#index' # this will give you a helper method `root_path` that
                     # will take you to the home page which is welcome/index
                     # in our case

end
