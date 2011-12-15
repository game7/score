Score::Engine.routes.draw do

  resources :standings, :only => [:index]
  
  match 'admin/dashboard' => 'admin/dashboard#index'
  
  namespace :admin do
    resources :seasons, :shallow => true do
      resources :divisions do
        resources :teams do
          resources :players, :only => [ :new, :create, :edit, :update, :destroy ]
        end
      end
    end
    resources :clubs
    resources :organizations
    resources :venues
    #resources :teams, :shallow => true, :only => [] do
    #  resources :players, :only => [ :new, :create, :edit, :update, :destroy ]
    #end
    resources :teams, :only => [] do
      resource :logo, :only => [ :edit, :update ]
    end
    resources :events
    resources :games, :only => [ :new, :create ], :shallow => true do
      resource :game_result, :only => [ :new, :create, :edit, :update, :destroy ]
    end
    resources :hockey_games, :only => [ :new, :create, :edit, :update ], :shallow => true do
      resource :result, :controller => "hockey_game_results", :only => [ :new, :create, :destroy ]
    end
  end

end

