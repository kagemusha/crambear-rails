Crambear::Application.routes.draw do

  devise_for :users, controllers: { sessions: 'sessions' }

  #eek fix
  resources :card_sets
  resources :cards
  resources :labels
  resources :results
  root :to => 'home#index'

end

