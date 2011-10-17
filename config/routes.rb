Score::Engine.routes.draw do

  get "game_results/new"

  get "game_results/create"

  get "game_results/destroy"

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
    resources :games, :only => [ :new, :create, :edit, :update ], :shallow => true do
      resources :game_results, :only => [ :new, :create, :destroy ]
    end
  end

end

