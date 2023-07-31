Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :reservations do
    collection do
      post "confirm"
      post "back"
      get "check"
      get "no_reservation"
      post "search"


    end

  end
  

  root to: "saikas#index"
  
  resources :saikas do
  # root追加
    collection do
      get "about"
      get "service"
      get "admin"

    end
  end
end
