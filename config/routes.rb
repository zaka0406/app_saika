Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: "saikas#index"

  resources :saikas,only:[:index] do
  # root追加
    collection do
      get "about"
    end
  end

end
