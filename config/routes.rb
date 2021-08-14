Rails.application.routes.draw do
  root to: 'homes#top'
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  resources :users, except: [:new, :create, :destroy] do
    resource :frendships, only: [:create, :destroy]
    get '/follower' => "frendships#follower", as: "follower"
    get '/followed' => "frendships#followed", as: "followed"
  end
  resources :books, except: [:new] do
    resource :favorites, only: [:create, :destroy]
    resource :book_comments, only: [:create, :destroy]
  end
  get '/search' => "searches#index", as: "search"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
