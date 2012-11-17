Cineto::Application.routes.draw do
  root :to => "pages#show", :id => "home"

  resources :pages, :only => [:show]

  resources :torrents, :only => [:index, :show, :new, :create, :destroy] do
    get :download, :on => :collection
  end
end
