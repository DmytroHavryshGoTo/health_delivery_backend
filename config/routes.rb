Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      post 'sign_in', to: 'auth#create'
      resources :users, only: %i[create index update] do
        collection do
          get :me
        end
      end
      resources :deliveries do
        post :damage, on: :member
        get :search, on: :collection
      end

      resources :ads, only: %i[index create show update]

      resource :settings, only: [] do
        collection do
          get :dumps
          post :create_dump
          post :restore_dump
          put :update_ssl
        end
      end
    end
  end
end
