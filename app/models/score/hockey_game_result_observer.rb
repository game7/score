class Score::HockeyGameResultObserver < Mongoid::Observer
  
  def after_create(game_result)
    post_to_team_records(game_result.game) if game_result.final?
  end
  
  private 
  
    def post_to_team_records(game)
      post_to_team_record(game.home_team.record, game) if game.home_team
      post_to_team_record(game.away_team.record, game) if game.away_team
    end
    
    def post_to_team_record(team_record, game)
      team_record.post_game(game) and team_record.save
    end
  
end
