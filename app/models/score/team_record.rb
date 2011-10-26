module Score
  class TeamRecord
    include Mongoid::Document
    
    field :gp, :type => Integer, :default => 0
    field :w, :type => Integer, :default => 0
    field :l, :type => Integer, :default => 0
    field :t, :type => Integer, :default => 0
    field :otl, :type => Integer, :default => 0
    field :sol, :type => Integer, :default => 0
    
    field :pts, :type => Integer, :default => 0
    field :pct, :type => Float, :default => 0.00
    
    field :scored, :type => Integer, :default => 0
    field :allowed, :type => Integer, :default => 0
    field :margin, :type => Integer, :default => 0
    
    field :last, :type => String
    field :run, :type => Integer, :default => 0
    field :stk, :type => String
    
    embedded_in :team, :class_name => "Score::Team"
    embeds_many :results, :class_name => "Score::TeamGameResult"
    
    def reset!
      self.gp = 0
      self.w = 0
      self.l = 0
      self.t = 0
      self.otl = 0
      self.sol = 0
            
      self.pts = 0
      self.pct = 0.00
            
      self.scored = 0
      self.allowed = 0
      self.margin = 0
      
      self.last = nil
      self.run = 0
      self.stk = nil 
      
      self.results.each{ |r| r.delete }
    end
    
    def post_result_from_game(game)
      raise 'Game already posted to team record' if game_posted?(game)
      apply_result Score::TeamGameResult.new(:team => self.team.id, :game => game)
    end
    
    def remove_result_for_game(game)
      remove_result self.results.where( :game_id => game.id ).first
    end
    
    def apply_result(result)
      self.gp += 1
      apply_decision(result.decision, result.completed_in, 1)
      self.update_points!
      self.update_win_percentage!
      self.scored += result.scored
      self.allowed += result.allowed
      self.update_margin!
      
      self.resuts << result
      
      self.update_streak!
    end
    
    def remove_result(result)
      self.gp -= 1
      apply_decision(result.decision, result.completed_in, -1)
      self.update_points!
      self.update_win_percentage!
      self.scored -= result.scored
      self.allowed -= result.allowed
      self.update_margin!
      self.update_streak!
      
    end
    
    def game_posted?(game)
      results.where(:game_id => game.id).count > 0
    end

    def update_margin!
      self.margin = self.scored = self.allowed
    end

  end
end