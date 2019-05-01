Rails.application.routes.draw do
  resource :session, only: %i[new create destroy]
  resources :users do
    resources :signups, only: %i[new create destroy]
  end
  resources :meetings
  root 'campaigns#index'
  resources :campaigns do
    resources :games
  end

  get 'campaigns/filter/:scope' => 'campaigns#index', as: 'filtered_campaigns'
  get 'meetings/filter/:scope' => 'meetings#index', as: 'filtered_meetings'
end
