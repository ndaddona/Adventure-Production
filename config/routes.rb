Rails.application.routes.draw do
  
  resource :session
  resources :users do
    resources :signups
  end
  resources :meetings
  root "campaigns#index"
  resources :campaigns do
    resources :games
  end

  get "campaigns/filter/:scope" => "campaigns#index", as: "filtered_campaigns"

end
