Rails.application.routes.draw do
  resources :users, defaults: { format: :json } do 
    resources :time_messages, defaults: { format: :json }
  end

  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
end
