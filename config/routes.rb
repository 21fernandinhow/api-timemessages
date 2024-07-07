Rails.application.routes.draw do
  resources :users, param: :email, constraints: { email: /[^\/]+/ }, defaults: { format: :json } do
    resources :time_messages, only: [:index, :show, :create, :update, :destroy], defaults: { format: :json }
  end

  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
end
