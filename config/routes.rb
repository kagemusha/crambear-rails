Crambear::Application.routes.draw do

  devise_for :users

  resources :card_sets
  resources :cards
  resources :labels
  resources :results
  resources :card_sets do
    resources :cards
    resources :labels
  end

  root :to => 'home#index'

end

