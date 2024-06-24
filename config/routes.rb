Rails.application.routes.draw do
  namespace :admin do
    resources :users, only: %i[index show update destroy]
    resources :events, only: %i[index show create update destroy]
  end

  resources :attendances
  resources :skills
  resources :publications
  resources :event_instruments
  resources :instruments
  resources :events
  devise_for :users,
             controllers: {
               sessions: 'users/sessions',
               registrations: 'users/registrations'
             }

  resources :users, only: %i[index show update destroy]
  resources :users, only: [:show, :update] do
    member do
      patch :change_password
    end
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
