Limouzi::Application.routes.draw do
  resources :areas do
    get :proximity_area, :on => :collection
  end
  resources :areas_v2
  root :to => "areas#index"
end
