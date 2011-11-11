Score::Engine.routes.draw do

  namespace :admin do
    resources :seasons, :shallow => true do
      resources :divisions
    end
    resources :clubs
    resources :venues
    resources :teams
    resources :events, :only => [ :index, :new, :create, :destroy] do
      resources :reschedules, :only => [ :new, :create ]
    end
    resources :games, :only => [ :new, :create ], :shallow => true do
      resource :game_result, :only => [ :new, :create, :destroy ]
    end
  end

end

