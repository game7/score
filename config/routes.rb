Score::Engine.routes.draw do

  get "hockey_game_results/new"

  get "hockey_game_results/edit"

  namespace :admin do
    resources :seasons, :shallow => true do
      resources :divisions
    end
    resources :clubs
    resources :venues
    resources :teams
    resources :events
    resources :games, :only => [ :new, :create ], :shallow => true do
      resource :game_result, :only => [ :new, :create, :edit, :update, :destroy ]
    end
    resources :hockey_games, :only => [ :new, :create, :edit, :update ], :shallow => true do
      resource :result, :controller => "hockey_game_results", :only => [ :new, :create, :destroy ]
    end
  end

end

