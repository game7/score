module Score
  class TeamGameResult
    include Mongoid::Document
    
    COMPLETED_IN = %w[regulation overtime shootout forfeit]
    DECISION = %[win loss tie]
    
    field :played_on, :type => Date
    field :opponent_name, :type => String
    field :decision, :type => String
    field :completed_in, :type => String
    field :scored, :type => Integer, :default => 0
    field :allowed, :type => Integer, :default => 0
    
    embedded_in :team_record, :class_name => "Score::TeamRecord", :inverse_of => :results
    referenced_in :game, :class_name => "Score::Game"
    referenced_in :opponent, :class_name => "Score::Team"
    
    def initialize(params = nil)
      super(nil)
      self.load_team_and_game(params[:team], params[:game]) if params[:game] && params[:team] if (params && params[:game] && params[:team])
    end
    
    def set_decision      
      margin = scored - allowed
      self.decision = 'win' and return if margin > 0
      self.decision = 'tie' and return if margin == 0
      self.decision = 'loss' and return if margin < 0
    end   
    
    def load_team_and_game(team, game)

      team_id = team.class == Score::Team ? team.id : team
    
      self.game_id = game.id
      self.played_on = game.starts_on.to_date
      self.completed_in = game.completed_in
    
      self.opponent_id = game.opponent_id(team)
      self.opponent_name = game.opponent_name(team)
      self.scored = game.team_score(team)
      self.allowed = game.opponent_score(team)
    
      self.set_decision

    end
  
  end
end
