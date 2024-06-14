Rails.application.routes.draw do
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
  get '/member-data', to: 'members#show'

  get "up" => "rails/health#show", as: :rails_health_check
end
