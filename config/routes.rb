Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'ui/leaves#index'

  namespace :api, defaults: { format: :json }, path: '/' do
    scope module: :v1 do
      resources :quotes, only: [:index, :show]
    end
  end

  # For react UI requests
  match '*path', to: 'ui/leaves#index', via: :all
end
