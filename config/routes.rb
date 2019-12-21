Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'ui/leaves#index'

  namespace :api, defaults: { format: :json }, path: '/', constraints: ApiRequestCheck.new do
    scope module: :v1 do
      resources :quotes, only: [:index, :show]
    end
  end

  # When making invalid API-only requests, show 404 and 500
  match "/404", to: "application#action_not_found", via: [:all]
  match "/500", to: "application#internal_server_error", via: [:all]

  # For react UI requests
  match '*path', to: 'ui/leaves#index', via: :all, constraints: UiRequestCheck.new
end
