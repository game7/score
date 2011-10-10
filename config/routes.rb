Score::Engine.routes.draw do

  get "games/new"

  get "games/edit"

  namespace :admin do
    resources :seasons, :shallow => true do
      resources :divisions
    end
    resources :clubs
    resources :venues
    resources :teams
    resources :events
    resources :games, :only => [ :new, :create, :edit, :update ]
  end

end

