SchoolShop::Application.routes.draw do
  resources :garment_types
  resources :garments do
    member { match :sell, :via => [:get, :put] }
  end
  root :to => 'garments#index'
end
