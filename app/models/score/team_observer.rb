class Score::TeamObserver < Mongoid::Observer
  
  def after_create(team)
    team.division.team_created
    team.division.save
  end
  
  def after_destroy(team)
    if division = Score::Division.find(team.division_id)
      division.team_destroyed
      division.save
    end
  end

end
