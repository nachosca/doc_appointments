Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check


  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :doctors, only: [] do
        member do
          get 'working_hours', to: 'doctors#working_hours'
          get 'availability', to: 'doctors#availability'
        end
      end
     resources :appointments, only: [] do
        member do
          post :book
          patch :update
          delete :destroy
        end
      end
    end
  end
end
