Crambear::Application.routes.draw do

  devise_for :users, controllers: { sessions: 'sessions' }

  resources :card_sets
  resources :labels

  resources :cards
  resources :results
  root :to => 'home#index'

end

