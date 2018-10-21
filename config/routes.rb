Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'bands#index'

  resources :users, only: [:new, :create, :show]

  resource :session, only: [:new, :create, :destroy]

  resources :bands, only: [:index, :create, :new, :edit, :show, :update, :destroy] do
    resources :albums, only: [:new]
  end

  resources :albums, only: [:create, :edit, :index, :show, :update, :destroy] do
    resources :tracks, only: [:new]
  end

  resources :tracks, only: [:create, :edit, :index, :show, :update, :destroy]

  resources :notes, only: [:create, :destroy, :edit, :update]

end
