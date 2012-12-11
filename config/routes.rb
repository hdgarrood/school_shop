SchoolShop::Application.routes.draw do
  match "search" => 'search#index', :via => :get
  resources :garment_types
  resources :garments
  resources :sales
  root :to => 'garments#index'
end
