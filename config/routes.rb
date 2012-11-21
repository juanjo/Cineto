Cineto::Application.routes.draw do
  root :to => "pages#show", :id => "home"

  resources :pages, :only => [:show]

  match "torrents/add/:uri" => "torrents#create"

  resources :torrents, :only => [:index, :create, :destroy] do
    get :download, :on => :collection
  end

  match "video" => "files#show"
end
