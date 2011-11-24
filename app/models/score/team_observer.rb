class Score::TeamObserver < Mongoid::Observer
  
  def after_create(team)
    team.division.team_created
    team.division.save
  end
  
  def after_destroy(team)
    if division = team.division
      team.division.team_destroyed
      team.division.save
    end
  end

end
