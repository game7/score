Score::Engine.routes.draw do

  namespace :admin do
    resources :divisions
    resources :seasons
    resources :clubs
    resources :venues
  end

end

