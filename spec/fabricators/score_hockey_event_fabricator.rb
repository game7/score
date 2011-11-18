Fabricator(:hockey_event, :class_name => Score::HockeyEvent, :from => :event) do
  summary ""
  home_team { Fabricate(:team) }
  away_team { Fabricate(:team) } 
end
