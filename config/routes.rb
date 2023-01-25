Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root to: "projects#index"
  resources :projects do
    resources :issues do
      member do
        post :add_comment
      end
    end
  end
end
