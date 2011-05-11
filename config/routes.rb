Timehook::Application.routes.draw do

  resources :users
  resources :sessions, :only => [:new, :create, :destroy]
  resources :activities, :only => [:create, :destory, :edit, :update]

  root :to => "pages#home"

  match '/register',  :to => 'users#new'
  match '/signin',    :to => 'sessions#new'
  match '/signout',   :to => 'sessions#destroy'
  match '/date',      :to => 'activities#choose_date'
  match '/summary',   :to => 'activities#summary'
end

