Rails.application.routes.draw do
  resources :logins
  resources :notes
  post 'auth/login', to: 'authentication#authenticate'
end
