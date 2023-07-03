Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :reservations do
    collection do
      post "confirm"
      post "back"
    end
  end
  

  root to: "saikas#index"
  
  resources :saikas,only:[:index] do
  # root追加
    collection do
      get "about"
      get "service"
    end
  end
end
