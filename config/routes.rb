Score::Engine.routes.draw do

  namespace :admin do
    resources :divisions
    resources :seasons
  end

end

