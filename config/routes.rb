Rails.application.routes.draw do
  devise_for :users
  namespace :api do
    namespace :v1 do
      post 'search', to: 'search#create'
    end
  end
end
