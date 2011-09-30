Score::Engine.routes.draw do

  namespace :admin do
    resources :seasons do
      resources :divisions
    end
    resources :clubs
    resources :venues
  end

end

