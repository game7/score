Score::Engine.routes.draw do

  namespace :admin do
    resources :seasons, :shallow => true do
      resources :divisions
    end
    resources :clubs
    resources :venues
    resources :teams
    resources :events
  end

end

