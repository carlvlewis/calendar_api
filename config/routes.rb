Rails.application.routes.draw do

  root 'public#index'

  devise_for :users, :skip => [:registrations]

  authenticate :user do
    ActiveAdmin.routes(self)
  end

  resources :sources, only: [:new, :create]
  resources :events, only: [:new, :create]

  scope '/api' do
    scope '/v1' do
      resources :events, only: [:index, :show], defaults: { format: :json } do
        collection do
          get :search, action: :search
        end
      end
      resources :sources, only: [:index, :show], defaults: { format: :json }
    end
  end

end
