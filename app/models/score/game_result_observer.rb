module Score
  class GameResultObserver < Mongoid::Observer
    
    def after_create(game_result)
      
    end
    
    def after_destroy(game_result)
    
    end
    
  end
end
