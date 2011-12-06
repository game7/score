class Score::TeamObserver < Mongoid::Observer
  
  def after_create(team)
    if division = team.division
      division.team_created
      division.save
    end
  end
  
  def after_destroy(team)
    if division = team.division
      division.team_destroyed
      division.save
    end
  end

end
