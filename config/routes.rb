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

      resource :settings, only: [] do
        get :dumps, on: :collection
        post :create_dump, on: :collection
        post :restore_dump, on: :collection
      end
    end
  end
end
