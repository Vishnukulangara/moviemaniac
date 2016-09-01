Rails.application.routes.draw do
  post '/rate' => 'rater#create', :as => 'rate'

  devise_for :users
  root 'movies#index'
  resources :movies do 
  	resources :reviews ,except: [:show, :index]
 	end

 	get "/movie/search"  => "movies#search"
end
