Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :sessions, only: %i[] do
        collection do
          post :sign_up
          post :sign_in
          post :sign_out
          post :refresh
          post :send_verification_code
          post :reset_password
        end
      end

      namespace :app do
        resources :categories, only: %i[index]
        resources :books, only: %i[index show] do
          collection do
            get :favorited
            get :read
          end

          member do
            post :favorite
            delete :unfavorite
          end
        end
        resources :chapters, only: %i[show]
      end
    end
  end
end
