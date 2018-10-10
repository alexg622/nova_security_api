Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api, defaults: {format: :json} do
    get '/users', to: 'api#get_user'
    get '/teams/:teamId', to: 'api#get_team'
    put '/teams/:teamId', to: 'api#update_team'
  end
  
end
