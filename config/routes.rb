# Rails.application.routes.draw do
#   post 'user_token' => 'user_token#create'
#   resources :users
#   # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
# end

# Rails.application.routes.draw do
#   scope '/api' do
#     resources :users
#     post 'user_token' => 'user_token#create'
#   end
# end

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :users 
      resources :games
      post 'games/timeline', to: 'games#create_timeline'
      post 'user_token' => 'user_token#create'
    end
  end 
  mount ActionCable.server => '/game'

end
