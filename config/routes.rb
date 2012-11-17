Cineto::Application.routes.draw do
  root :to => "torrents#index"

  resources :torrents, :only => [:index, :show, :new, :create, :destroy]
end
