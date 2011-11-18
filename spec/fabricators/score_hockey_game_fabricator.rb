Fabricator(:hockey_game, :class_name => Score::HockeyGame, :from => :event) do
  summary ""
  home_team { Fabricate(:team) }
  away_team { Fabricate(:team) } 
end
