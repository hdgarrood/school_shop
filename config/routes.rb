SchoolShop::Application.routes.draw do
  match "search" => 'search#index', :via => :get
  resources :garment_types
  resources :garments do
    member { match :sell, :via => [:get, :put] }
  end
  root :to => 'garments#index'
end
