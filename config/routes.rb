Timehook::Application.routes.draw do

  resources :users

  root :to => "pages#home"

  match '/register',  :to => 'users#new'
  match '/signin',    :to => 'sessions#new'
  match '/signout',   :to => 'sessions#destroy'
end

