Rails.application.routes.draw do
  devise_for :users
  post 'search', to: 'search#create'
end
